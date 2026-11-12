#!/usr/bin/env python3
"""Applies the smali edits required by the HUD to an apktool decode.

Two things happen:

1. the `MiuiStylusLevelsView` class is replaced with ours;
2. the smali that builds the `StylusBattery` window is retouched:
   - `windowAnimations` = 0   (no system window animation)
   - `format` = 1             (OPAQUE instead of TRANSLUCENT: removes the blur)
   - `privateFlags &= ~0x2`   (removes the window blur flag)
   - the dwell constant goes from 2000 ms (0x7d0) to 9000 ms (0x2328)

Every edit is anchored on the `LayoutParams` field name, so the script works
even when the obfuscated file name or the register allocation changes.

Exit code 0 when everything is applied, 1 when an anchor is missing
(the ROM then needs an adaptation).
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

TARGET_CLASS = "com/miui/miinput/stylus/battery/MiuiStylusLevelsView.smali"
DWELL_FROM = 0x7D0   # 2000 ms in the original MIUI code
DWELL_TO = 0x2328    # 9000 ms


def die(msg: str) -> "None":
    print("  [X] " + msg, file=sys.stderr)
    raise SystemExit(1)


def find_window_smali(smali_root: Path) -> Path:
    hits = []
    for p in smali_root.rglob("*.smali"):
        try:
            txt = p.read_text(errors="ignore")
        except OSError:
            continue
        if '"StylusBattery"' in txt and "windowAnimations:I" in txt:
            hits.append(p)
    if not hits:
        die('no smali builds the "StylusBattery" window '
            "(windowAnimations not found)")
    if len(hits) > 1:
        # several candidates: keep the one that also has privateFlags
        hits = [p for p in hits if "privateFlags:I" in p.read_text(errors="ignore")] or hits
    if len(hits) > 1:
        die("several candidate windows: " + ", ".join(str(p) for p in hits))
    return hits[0]


def set_const_before(lines, idx, want: int, field: str):
    """Replaces the constant loaded in the register passed to `iput ...field`."""
    m = re.match(r"^\s*iput (v\d+),", lines[idx])
    if not m:
        die("unexpected iput line for %s: %r" % (field, lines[idx]))
    reg = m.group(1)
    pat = re.compile(r"^(\s*)const(?:/4|/16|/high16)?\s+" + reg + r",\s*(\S+)\s*$")
    for j in range(idx - 1, max(-1, idx - 60), -1):
        mm = pat.match(lines[j].rstrip("\n"))
        if mm:
            lines[j] = "%sconst/4 %s, 0x%x\n" % (mm.group(1), reg, want) if want <= 7 \
                else "%sconst/16 %s, 0x%x\n" % (mm.group(1), reg, want)
            return mm.group(2)
    die("no constant loaded into %s before %s" % (reg, field))


def main(argv) -> int:
    if len(argv) != 3:
        print("usage: patch_smali.py <dec_dir> <smali_class.smali>", file=sys.stderr)
        return 2
    dec = Path(argv[1])
    src_class = Path(argv[2])
    smali_root = dec / "smali"
    if not smali_root.is_dir():
        die("no smali/ folder in " + str(dec))

    # ---- 1. HUD class -----------------------------------------------------
    dst = smali_root / TARGET_CLASS
    if not dst.parent.is_dir():
        die("class %s is missing: is this really SecurityCoreAdd?" % TARGET_CLASS)
    dst.write_text(src_class.read_text())
    print("  [ok] class replaced : %s" % TARGET_CLASS)

    # ---- 2. window --------------------------------------------------------
    win = find_window_smali(smali_root)
    print("  [ok] window found   : %s" % win.relative_to(dec))
    lines = win.read_text().splitlines(keepends=True)

    def idx_of(field: str) -> int:
        for i, l in enumerate(lines):
            if re.search(r"Landroid/view/WindowManager\$LayoutParams;->%s:I" % field, l) and l.strip().startswith("iput"):
                return i
        die("field %s not found in %s" % (field, win.name))

    i = idx_of("windowAnimations")
    old = set_const_before(lines, i, 0x0, "windowAnimations")
    print("  [ok] windowAnimations : %s -> 0x0" % old)

    i = idx_of("format")
    old = set_const_before(lines, i, 0x1, "format")
    print("  [ok] format           : %s -> 0x1 (OPAQUE)" % old)

    # privateFlags : or-int/lit8 vX, vX, 0x2 juste avant l'iput
    i = idx_of("privateFlags")
    reg = re.match(r"^\s*iput (v\d+),", lines[i]).group(1)
    done = False
    for j in range(i - 1, max(-1, i - 20), -1):
        m = re.match(r"^(\s*)or-int/lit8 (" + reg + r"), (" + reg + r"),\s*(\S+)\s*$", lines[j].rstrip("\n"))
        if m:
            lines[j] = "%sor-int/lit8 %s, %s, 0x0\n" % (m.group(1), reg, reg)
            done = True
            break
    if not done:
        die("or-int/lit8 on privateFlags not found")
    print("  [ok] privateFlags     : blur flag removed")

    # dwell (durée d'affichage du popup)
    txt = "".join(lines)
    m = re.search(r"const/16 (p\d+), 0x7d0", txt)
    if m:
        txt = txt.replace(m.group(0), "const/16 %s, 0x%x" % (m.group(1), DWELL_TO), 1)
        print("  [ok] dwell            : 0x7d0 (2 s) -> 0x%x (%d s)" % (DWELL_TO, DWELL_TO // 1000))
    elif re.search(r"const/16 p\d+, 0x2328", txt):
        print("  [ok] dwell            : already 9 s")
    else:
        die("dwell constant (0x7d0) not found")

    win.write_text(txt)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
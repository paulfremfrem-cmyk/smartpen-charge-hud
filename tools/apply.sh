#!/usr/bin/env bash
# Builds a patched SecurityCoreAdd.apk (Smart Pen HUD) and the KernelSU/Magisk module.
#
# Requirements:
#   java, apktool, python3, zip/unzip
#   Android build-tools (zipalign + apksigner): ANDROID_BUILD_TOOLS or an SDK install
#   the ORIGINAL APK extracted from YOUR ROM (never distributed here)
#   a signing key: ideally your ROM's platform key
#
# Examples:
#   ./tools/apply.sh --apk ./SecurityCoreAdd.apk --dry-run
#   ./tools/apply.sh --apk ./SecurityCoreAdd.apk \
#                    --key ./platform.pk8 --cert ./platform.x509.pem --version v1
set -euo pipefail

HERE="$(cd "$(dirname "$0")/.." && pwd)"
APK=""
KEY=""
CERT=""
OUT="$HERE/out"
VERSION="v1"
MODULE_ID="smartpen_charge_hud"
MODULE_NAME="Smart Pen Charge HUD"
DRY_RUN=0
WHITELIST=1
REQUIRE_SAME_KEY=0

usage() {
  sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'
  echo "options: --apk --key --cert --out --version --module-id --module-name"
  echo "         --dry-run --no-whitelist --require-same-key"
  exit 2
}

while [ $# -gt 0 ]; do
  case "$1" in
    --apk) APK="$2"; shift 2;;
    --key) KEY="$2"; shift 2;;
    --cert) CERT="$2"; shift 2;;
    --out) OUT="$2"; shift 2;;
    --version) VERSION="$2"; shift 2;;
    --module-id) MODULE_ID="$2"; shift 2;;
    --module-name) MODULE_NAME="$2"; shift 2;;
    --dry-run) DRY_RUN=1; shift;;
    --no-whitelist) WHITELIST=0; shift;;
    --require-same-key) REQUIRE_SAME_KEY=1; shift;;
    -h|--help) usage;;
    *) echo "unknown option: $1" >&2; usage;;
  esac
done

[ -n "$APK" ] && [ -f "$APK" ] || { echo "--apk missing or not found" >&2; exit 2; }
if [ "$DRY_RUN" -eq 0 ]; then
  [ -f "${KEY:-/nonexistent}" ] || { echo "--key missing" >&2; exit 2; }
  [ -f "${CERT:-/nonexistent}" ] || { echo "--cert missing" >&2; exit 2; }
fi
command -v java >/dev/null || { echo "java not found" >&2; exit 2; }
command -v apktool >/dev/null || { echo "apktool not found (brew install apktool)" >&2; exit 2; }
command -v python3 >/dev/null || { echo "python3 not found" >&2; exit 2; }

# --- build-tools -----------------------------------------------------------
BT="${ANDROID_BUILD_TOOLS:-}"
if [ -z "$BT" ]; then
  for root in "${ANDROID_HOME:-}" "${ANDROID_SDK_ROOT:-}" "$HOME/Library/Android/sdk" "$HOME/Android/Sdk"; do
    [ -n "$root" ] && [ -d "$root/build-tools" ] || continue
    BT="$root/build-tools/$(ls -1 "$root/build-tools" | sort -V | tail -1)"
    break
  done
fi
[ -n "$BT" ] && [ -x "$BT/zipalign" ] || {
  echo "zipalign not found: export ANDROID_BUILD_TOOLS=/path/to/build-tools/X" >&2; exit 2; }
ZIPALIGN="$BT/zipalign"
APKSIGNER="$BT/apksigner"

WORK="$(mktemp -d "${TMPDIR:-/tmp}/smartpen.XXXXXX")"
trap '[ "${KEEP_WORK:-0}" = "1" ] || rm -rf "$WORK"' EXIT
echo "== workdir: $WORK"

echo "== 1/5 decoding with apktool"
apktool d -r -f "$APK" -o "$WORK/dec" >"$WORK/decode.log" 2>&1 || { tail -20 "$WORK/decode.log"; exit 1; }

echo "== 2/5 patching smali"
python3 "$HERE/tools/patch_smali.py" "$WORK/dec" \
  "$HERE/smali/com/miui/miinput/stylus/battery/MiuiStylusLevelsView.smali"
[ "$DRY_RUN" -eq 1 ] && { echo "== dry-run: anchors OK, nothing was built"; exit 0; }

echo "== 3/5 rebuilding with apktool"
apktool b "$WORK/dec" -o "$WORK/patched.apk" >"$WORK/build.log" 2>&1 || { tail -20 "$WORK/build.log"; exit 1; }

echo "== 4/5 injecting the dex + signing"
mkdir -p "$WORK/out"
unzip -o -q "$WORK/patched.apk" classes.dex -d "$WORK/out"
cp "$APK" "$WORK/out/app.apk"
( cd "$WORK/out" && zip -q -X app.apk classes.dex && zip -q -d app.apk 'META-INF/*.RSA' 'META-INF/*.SF' 'META-INF/*.MF' >/dev/null )
"$ZIPALIGN" -p -f 4 "$WORK/out/app.apk" "$WORK/out/aligned.apk"
"$APKSIGNER" sign --key "$KEY" --cert "$CERT" --min-sdk-version 34 \
  --out "$WORK/out/signed.apk" "$WORK/out/aligned.apk"
"$APKSIGNER" verify --print-certs "$WORK/out/signed.apk" | head -2

# --- safety check: signature vs the original APK ---------------------------
orig_cert="$("$APKSIGNER" verify --print-certs "$APK" 2>/dev/null | grep -m1 -i 'SHA-256 digest' || true)"
new_cert="$("$APKSIGNER" verify --print-certs "$WORK/out/signed.apk" 2>/dev/null | grep -m1 -i 'SHA-256 digest' || true)"
echo "   original cert : ${orig_cert:-unknown}"
echo "   new cert      : ${new_cert:-unknown}"
if [ -n "$orig_cert" ] && [ "$orig_cert" != "$new_cert" ]; then
  echo "!! WARNING: this key is NOT the one that signed the original APK." >&2
  echo "   PackageManager may reject the app and break com.miui.securitycore." >&2
  echo "   Prefer your ROM's platform key. See SAFETY.md." >&2
  [ "$REQUIRE_SAME_KEY" -eq 1 ] && { echo "   aborted (--require-same-key)"; exit 1; }
fi

echo "== 5/5 building the KernelSU / Magisk module"
mkdir -p "$OUT"
cp "$WORK/out/signed.apk" "$OUT/SecurityCoreAdd-patched.apk"
MOD="$WORK/module"
cp -R "$HERE/module" "$MOD"
mkdir -p "$MOD/system/product/app/SecurityCoreAdd"
cp "$WORK/out/signed.apk" "$MOD/system/product/app/SecurityCoreAdd/SecurityCoreAdd.apk"
[ "$WHITELIST" -eq 0 ] && rm -rf "$MOD/system/etc/sysconfig"
cat > "$MOD/module.prop" <<EOF
id=$MODULE_ID
name=$MODULE_NAME
version=$VERSION
versionCode=1
author=smartpen-charge-hud
description=Smart Pen charging HUD for Xiaomi tablets, inspired by the iPadOS Apple Pencil overlay. Replaces MiuiStylusLevelsView with a slide-in tile from the top edge and a hand-drawn Xiaomi pen gauge. Built locally from the user's own SecurityCoreAdd.apk; no Xiaomi files are redistributed. Disable the module and reboot to roll back.
EOF
ZIP="$OUT/${MODULE_ID}_${VERSION}.zip"
( cd "$MOD" && rm -f "$ZIP" && zip -qr "$ZIP" module.prop system )

echo
echo "APK : $OUT/SecurityCoreAdd-patched.apk"
echo "ZIP : $ZIP"
echo "md5 : $( (md5 -q "$ZIP" 2>/dev/null || md5sum "$ZIP" | cut -d' ' -f1) )"
echo
echo "Install (KernelSU / APatch):"
echo "  adb push \"$ZIP\" /data/local/tmp/"
echo "  adb shell su -c 'ksud module install /data/local/tmp/$(basename "$ZIP")'"
echo "  adb reboot"
echo
echo "Record a problem? Read SAFETY.md first."
# Safety — read this before flashing

This module replaces a **system application** (`/system/product/app/SecurityCoreAdd/SecurityCoreAdd.apk`)
and a **system config file** (`/system/etc/sysconfig/hiddenapi-package-whitelist.xml`) on a rooted device.
If something goes wrong, the stylus popup can disappear, `com.miui.securitycore` can crash in a loop,
or the device can fail to finish booting.

**Nobody here can be held responsible for a bricked device, lost data, or a warranty voided by rooting.**
The software is provided under the MIT license, *as is*, without warranty of any kind.

That said, a few rules make the risk very small.

## 1. Before you flash

- Take a **full backup** (at least `/data`, and a boot image backup from your root manager).
- Run the dry-run and make sure every anchor is found:
  `./tools/apply.sh --apk ./SecurityCoreAdd.apk --dry-run`
- Check that your signing key matches the original APK: `apksigner verify --print-certs SecurityCoreAdd.apk`.
  A different key is the #1 cause of a broken system app. `apply.sh` warns about it;
  add `--require-same-key` to make the build fail instead.
- Keep the **original APK** and the **original whitelist** somewhere safe.
- Make sure you know how to enter your root manager's safe mode on this device *before* you need it.

## 2. If the device boots but the HUD is gone / securitycore crashes

Boot normally, then disable or remove the module:

```bash
adb shell su -c 'touch /data/adb/modules/smartpen_charge_hud/disable'
adb reboot
```

or, if `adb` works but you prefer a clean removal:

```bash
adb shell su -c 'ksud module uninstall smartpen_charge_hud'
adb reboot
```

Magisk users: `magisk --remove-modules` (or the same `disable` file), then reboot.

## 3. If the device does not boot (bootloop)

The module is a plain overlay: **disabling it is enough**, nothing has to be reinstalled.

1. **Root manager safe mode** — on KernelSU / KernelSU-Next / APatch, hold **Volume Down**
   while booting until the splash appears; modules are skipped for that boot.
   On Magisk, the same trick exists (safe mode), check your version's docs.
2. **Recovery / fastboot** — if adb is not available:
   - boot to recovery and, with the data partition mounted:
     `touch /data/adb/modules/smartpen_charge_hud/disable`
   - or delete that folder: `/data/adb/modules/smartpen_charge_hud/`
3. **Worst case** — restore your `boot.img` backup, or flash your ROM's `boot`/`init_boot`;
   the module lives in `/data`, so a data wipe also removes it.

The module never writes to `/system` (it is an overlay mount) and never touches `/data` other
than its own folder, so removing that folder always returns the device to its previous state.

## 4. What can actually go wrong, and why

| Symptom | Cause | Fix |
|---|---|---|
| No popup at all | hidden-API whitelist missing → the app cannot access the private APIs it needs | keep the bundled whitelist, or merge the line into your ROM's file |
| Popup shows but stays a grey rectangle | resources not found on this ROM | adapt `ID_CHARGING_ICON` / `ID_BOLT`, or report the `--dry-run` output |
| `com.miui.securitycore` crash loop | APK signed with a key the system refuses, or a broken dex | disable the module, rebuild with the correct key |
| Device does not boot | very unlikely with an overlay module, but a crashing system app can take the UI with it | safe mode, then disable |

## 5. Reporting a problem

Open an issue with:

- tablet model and codename (`getprop ro.product.device`), ROM version (`getprop ro.build.version.incremental`);
- `SecurityCoreAdd` versionName (`dumpsys package com.miui.securitycore | grep versionName`);
- the full output of `./tools/apply.sh --apk ./SecurityCoreAdd.apk --dry-run`;
- `adb logcat -d -b crash` and `adb shell dumpsys package com.miui.securitycore | head -40`.

Never paste your `platform.pk8` or a signed APK.
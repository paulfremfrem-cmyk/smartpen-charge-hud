#!/usr/bin/env bash
# Pulls SecurityCoreAdd.apk from a tablet connected over adb (root).
# The file stays on your machine: it is never committed nor published.
set -euo pipefail

SERIAL="${1:-}"
APK_PATH="/system/product/app/SecurityCoreAdd/SecurityCoreAdd.apk"
OUT="${2:-./SecurityCoreAdd.apk}"

ADB="adb"
[ -n "$SERIAL" ] && ADB="adb -s $SERIAL"

echo "== device"
$ADB shell getprop ro.product.model

echo "== copying the APK"
$ADB shell "su -c 'cp $APK_PATH /data/local/tmp/SecurityCoreAdd.apk; chmod 644 /data/local/tmp/SecurityCoreAdd.apk'"
$ADB pull /data/local/tmp/SecurityCoreAdd.apk "$OUT"
$ADB shell "su -c 'rm -f /data/local/tmp/SecurityCoreAdd.apk'"

echo "== info"
$ADB shell "dumpsys package com.miui.securitycore | grep -m1 versionName" || true
echo "signature:"
BT="${ANDROID_BUILD_TOOLS:-}"
if [ -n "$BT" ] && [ -x "$BT/apksigner" ]; then
  "$BT/apksigner" verify --print-certs "$OUT" | grep -m2 -E "Signer #1 (certificate DN|SHA-256)" || true
else
  echo "  (install build-tools, then: apksigner verify --print-certs $OUT)"
fi
echo "size      : $(wc -c < "$OUT") bytes"
echo "md5       : $( (md5 -q "$OUT" 2>/dev/null || md5sum "$OUT" | cut -d' ' -f1) )"
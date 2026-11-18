# Peridot Audio Props (MiSound ASC) — Magisk module

Restores the stock/LineageOS vendor + ODM audio properties that are missing on
this ROM build (The Clover Project, Android 17, peridot).

## Why
On stock HyperOS, the AW882xx smart amplifiers are driven through Xiaomi's
MiSound ASC path (`persist.vendor.audio.misoundasc=true`,
`ro.vendor.audio.aw.monitor=true`, stock gain staging). ROMs keep the stock
vendor HAL and the `/odm/etc/audio/misound_res_spk_power_*.bin` speaker profiles,
but if the props are not inherited from the device tree, the HAL falls back to
conservative defaults and the speaker is noticeably quieter.

LineageOS and crDroid peridot device trees ship this exact prop set
(`props/vendor.prop` + `props/odm.prop`, Audio sections). This module
re-applies it systemlessly.

## What it does NOT do
- Does not replace any audio XML (`audio_effects.xml` untouched; the
  `libmisoundfx.so` MiSound EQ effect does not exist on this vendor partition,
  so registering it would be dead weight).
- Does not modify the volume curve (speaker music curve already reaches 0 dB
  attenuation at index 100).
- Does not persist values: props are set at every boot from `props.txt`
  (runtime only) and disappear when the module is removed + rebooted.

## Requirements
- Root (Magisk, KernelSU-Next, SukiSU, APatch)
- peridot only (installer aborts on other devices)

## Install
1. Flash the zip in the root manager.
2. Reboot.
3. Check: `getprop persist.vendor.audio.misoundasc` → `true`
   `getprop ro.vendor.audio.gain.support` → `true`
   log: `/data/local/tmp/peridot_audio_props.log`

## Uninstall
Remove in root manager (uninstall.sh deletes the injected props) and reboot.

## If volume is still low
Verify the props applied (`getprop`), then inspect the vendor libs with root:
`strings /vendor/lib64/lib_misound_asc.so`, check logcat for `misound` /
`aw882xx` errors, and confirm the HAL picked the speaker power profile.

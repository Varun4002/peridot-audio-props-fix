#!/system/bin/sh
# Sourced by the Magisk/KernelSU/APatch module installer.

if [ "$(getprop ro.product.device)" != "peridot" ]; then
  abort "This module is only for peridot (POCO F6 / Redmi Turbo 3). Aborting."
fi

ui_print "- Device: $(getprop ro.product.model) ($(getprop ro.product.device))"
ui_print "- Restoring missing vendor/ODM audio props (MiSound ASC smart-amp)"
ui_print "- Systemless resetprop at post-fs-data, no files are replaced"

set_perm "$MODPATH/post-fs-data.sh" 0 0 0755
set_perm "$MODPATH/uninstall.sh" 0 0 0755
set_perm "$MODPATH/props.txt" 0 0 0644

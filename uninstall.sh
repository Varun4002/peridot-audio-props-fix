#!/system/bin/sh
# peridot-audio-props: remove the props we injected (they are runtime-only,
# so a reboot would clear them anyway; this makes removal immediate).

MODDIR=${0%/*}

while IFS='=' read -r name value; do
  case "$name" in
    ''|\#*) continue ;;
  esac
  resetprop --delete "$name"
done < "$MODDIR/props.txt"

rm -f /data/local/tmp/peridot_audio_props.log

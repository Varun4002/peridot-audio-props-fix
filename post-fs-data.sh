#!/system/bin/sh
# peridot-audio-props: restore vendor/ODM audio props stripped from this ROM build.
# Values are the stock / LineageOS-and-crDroid peridot set (MIUI HyperOS derived).
# Applied at post-fs-data (before audioserver / audio HAL start), runtime only.

MODDIR=${0%/*}
LOG=/data/local/tmp/peridot_audio_props.log

while IFS='=' read -r name value; do
  case "$name" in
    ''|\#*) continue ;;
  esac
  resetprop "$name" "$value"
done < "$MODDIR/props.txt"

{
  echo "peridot-audio-props applied: $(date)"
  echo "misoundasc=$(getprop persist.vendor.audio.misoundasc)"
  echo "misound.disable=$(getprop persist.vendor.audio.misound.disable)"
  echo "aw.monitor=$(getprop ro.vendor.audio.aw.monitor)"
  echo "gain.support=$(getprop ro.vendor.audio.gain.support)"
  echo "audio_hal.period_size=$(getprop vendor.audio_hal.period_size)"
  echo "cpu.sched=$(getprop vendor.audio.cpu.sched)"
} > "$LOG" 2>/dev/null

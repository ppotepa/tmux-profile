#!/usr/bin/env bash

set -u

path="${1:-}"
now="$(date +%s)"

cpu_segment() {
  local state_file="/tmp/tmux-cpu-${USER}.state"
  local line total idle
  local p_total p_idle d_total d_idle usage

  line="$(grep '^cpu ' /proc/stat 2>/dev/null | head -n1)" || return
  [ -n "$line" ] || return

  read -r _ u n s i io irq sirq st _rest <<< "$line"
  total=$((u + n + s + i + io + irq + sirq + st))
  idle=$((i + io))

  usage=0
  if [ -f "$state_file" ]; then
    read -r p_total p_idle < "$state_file" || true
    if [ "${p_total:-0}" -gt 0 ] && [ "$total" -gt "$p_total" ]; then
      d_total=$((total - p_total))
      d_idle=$((idle - p_idle))
      usage=$(( (100 * (d_total - d_idle)) / d_total ))
    fi
  fi
  printf "%s %s\n" "$total" "$idle" > "$state_file"

  [ "$usage" -lt 0 ] && usage=0
  [ "$usage" -gt 100 ] && usage=100

  if [ "$usage" -ge 80 ]; then
    color="colour196"
  elif [ "$usage" -ge 50 ]; then
    color="colour220"
  else
    color="colour82"
  fi

  printf "#[fg=%s]C%s%%#[default]" "$color" "$usage"
}

ram_segment() {
  local mem_total mem_avail used usage color used_gb total_gb
  mem_total="$(awk '/^MemTotal:/ {print $2}' /proc/meminfo 2>/dev/null)"
  mem_avail="$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo 2>/dev/null)"
  [[ "$mem_total" =~ ^[0-9]+$ ]] || return
  [[ "$mem_avail" =~ ^[0-9]+$ ]] || return
  [ "$mem_total" -gt 0 ] || return

  used=$((mem_total - mem_avail))
  usage=$((100 * used / mem_total))
  [ "$usage" -lt 0 ] && usage=0
  [ "$usage" -gt 100 ] && usage=100

  if [ "$usage" -ge 90 ]; then
    color="colour196"
  elif [ "$usage" -ge 70 ]; then
    color="colour220"
  else
    color="colour82"
  fi

  used_gb="$(awk -v v="$used" 'BEGIN{printf "%.1f", v/1024/1024}')"
  total_gb="$(awk -v v="$mem_total" 'BEGIN{printf "%.1f", v/1024/1024}')"

  printf "#[fg=%s]R[%s/%sG]#[default]" "$color" "$used_gb" "$total_gb"
}

battery_segment() {
  local bat
  for bat in /sys/class/power_supply/BAT*; do
    [ -d "$bat" ] || continue
    local cap status color mode
    cap="$(cat "$bat/capacity" 2>/dev/null || true)"
    status="$(cat "$bat/status" 2>/dev/null || true)"
    [[ "$cap" =~ ^[0-9]+$ ]] || continue

    mode="DIS"
    case "$status" in
      Charging) mode="CHG" ;;
      Full) mode="FULL" ;;
      Not\ charging) mode="IDLE" ;;
    esac

    if [ "$mode" = "CHG" ]; then
      color="colour45"
    elif [ "$cap" -le 20 ]; then
      color="colour196"
    elif [ "$cap" -le 50 ]; then
      color="colour220"
    else
      color="colour82"
    fi

    case "$mode" in
      CHG) mode="C" ;;
      FULL) mode="F" ;;
      IDLE) mode="I" ;;
      *) mode="D" ;;
    esac
    printf "#[fg=%s]B%s%s#[default]" "$color" "$cap" "$mode"
    return
  done
}

load_segment() {
  local l1 color
  l1="$(awk '{print $1}' /proc/loadavg 2>/dev/null)"
  [ -n "$l1" ] || return

  if awk "BEGIN {exit !($l1 >= 4.0)}"; then
    color="colour196"
  elif awk "BEGIN {exit !($l1 >= 2.0)}"; then
    color="colour220"
  else
    color="colour82"
  fi

  printf "#[fg=%s]L%s#[default]" "$color" "$l1"
}

temp_segment() {
  local t raw color
  raw="$(awk '($1+0)>0{print $1; exit}' /sys/class/thermal/thermal_zone*/temp 2>/dev/null)"
  [[ "$raw" =~ ^[0-9]+$ ]] || return

  if [ "$raw" -gt 1000 ]; then
    t=$((raw / 1000))
  else
    t="$raw"
  fi

  if [ "$t" -ge 85 ]; then
    color="colour196"
  elif [ "$t" -ge 70 ]; then
    color="colour220"
  else
    color="colour82"
  fi

  printf "#[fg=%s]T%sC#[default]" "$color" "$t"
}

last_commit_segment() {
  [ -n "$path" ] || return
  [ -d "$path" ] || return

  local ts diff value unit color
  ts="$(git -C "$path" log -1 --format=%ct 2>/dev/null)" || return
  [[ "$ts" =~ ^[0-9]+$ ]] || return

  diff=$((now - ts))
  [ "$diff" -lt 0 ] && diff=0

  if [ "$diff" -lt 3600 ]; then
    value=$((diff / 60))
    [ "$value" -lt 1 ] && value=1
    unit="m"
  elif [ "$diff" -lt 86400 ]; then
    value=$((diff / 3600))
    unit="h"
  elif [ "$diff" -lt 604800 ]; then
    value=$((diff / 86400))
    unit="d"
  else
    value=$((diff / 604800))
    unit="w"
  fi

  if [ "$diff" -ge 1209600 ]; then
    color="colour196"
  elif [ "$diff" -ge 259200 ]; then
    color="colour220"
  else
    color="colour82"
  fi

  printf "#[fg=%s]G%s%s#[default]" "$color" "$value" "$unit"
}

parts=()
parts+=("$(cpu_segment)")
parts+=("$(ram_segment)")

bat="$(battery_segment || true)"
[ -n "$bat" ] && parts+=("$bat")

load="$(load_segment || true)"
[ -n "$load" ] && parts+=("$load")

temp="$(temp_segment || true)"
[ -n "$temp" ] && parts+=("$temp")

last="$(last_commit_segment || true)"
[ -n "$last" ] && parts+=("$last")

if [ "${#parts[@]}" -eq 0 ]; then
  exit 0
fi

out="${parts[0]}"
for part in "${parts[@]:1}"; do
  out="${out} #[fg=colour240]| #[default]${part}"
done

printf "%s" "$out"

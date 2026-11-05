#!/bin/bash

INTERVAL=5

print_rate() {
  local v=$1 tenths
  if [ "$v" -lt 1000 ]; then
    printf '%s B/s' "$v"
  elif [ "$v" -lt 1000000 ]; then
    printf '%s kB/s' "$(( (v + 500) / 1000 ))"
  else
    tenths=$(( (v + 50000) / 100000 ))
    printf '%s.%s MB/s' "$((tenths / 10))" "$((tenths % 10))"
  fi
}

skip_interface() {
  local iface=$1
  [ "$iface" = "lo" ] && return 0
  [ -d "/sys/class/net/$iface/bridge" ] && return 0
  case "$iface" in
    veth*|docker*|br-*|virbr*|vmnet*|vboxnet*|ifb*|dummy*|tun*|tap*|wg*) return 0 ;;
  esac
  return 1
}

declare -A past_rx past_tx

collect() {
  local path iface now_rx now_tx rx_delta tx_delta
  down=0
  up=0
  shopt -s nullglob
  for path in /sys/class/net/*; do
    iface=${path##*/}
    skip_interface "$iface" && continue
    [ -r "$path/statistics/rx_bytes" ] && [ -r "$path/statistics/tx_bytes" ] || continue
    now_rx=$(<"$path/statistics/rx_bytes")
    now_tx=$(<"$path/statistics/tx_bytes")
    case "$now_rx" in ''|*[!0-9]*) continue ;; esac
    case "$now_tx" in ''|*[!0-9]*) continue ;; esac
    if [ -z "${past_rx[$iface]:-}" ]; then
      past_rx[$iface]=$now_rx
      past_tx[$iface]=$now_tx
      continue
    fi
    rx_delta=$((now_rx - past_rx[$iface]))
    tx_delta=$((now_tx - past_tx[$iface]))
    past_rx[$iface]=$now_rx
    past_tx[$iface]=$now_tx
    [ "$rx_delta" -lt 0 ] && rx_delta=0
    [ "$tx_delta" -lt 0 ] && tx_delta=0
    down=$((down + rx_delta / INTERVAL))
    up=$((up + tx_delta / INTERVAL))
  done
}

collect
while true; do
  sleep "$INTERVAL"
  collect
  printf 'UP %s | DL %s\n' "$(print_rate "$up")" "$(print_rate "$down")"
done

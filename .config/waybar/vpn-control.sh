#!/usr/bin/zsh

SERVICE="sing-box-vpn"

get_status() {
  if systemctl is-active --quiet "$SERVICE"; then
    echo 'ON'
  else
    echo 'OFF'
  fi
}

toggle_vpn() {
  if [[ $(get_status) == 'ON' ]]; then
    sudo systemctl stop "$SERVICE"
    echo 'OFF'
  else
    sudo systemctl start "$SERVICE"
    echo 'ON'
  fi
}

update_waybar() {
  pkill -SIGRTMIN+8 waybar
}

case "$1" in
  "--status") get_status ;;
  "--toggle") toggle_vpn; update_waybar ;;
  *) echo "Используйте --status или --toggle" ;;
esac

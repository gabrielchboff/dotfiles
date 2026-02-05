#!/bin/sh
option=$(echo -e "Logout\nReboot\nShutdown" | rofi -dmenu -p "Power")
case $option in
"Logout") logout ;;
"Reboot") systemctl reboot ;;
"Shutdown") systemctl poweroff ;;
esac

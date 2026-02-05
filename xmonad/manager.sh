#!/bin/sh
option=$(echo -e "Lock\nLogout\nReboot\nShutdown" | rofi -dmenu -p "Power")
case $option in
"Lock") ~/.config/xmonad/lock.sh ;;
"Logout") logout ;;
"Reboot") systemctl reboot ;;
"Shutdown") systemctl poweroff ;;
esac

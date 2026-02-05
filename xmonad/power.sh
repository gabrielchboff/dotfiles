#!/bin/sh
option=$(echo -e "Power Saver\nBalanced\nPerformance" | rofi -dmenu -p "Energy")
case $option in
"Power Saver") powerprofilesctl set power-saver ;;
"Balanced") powerprofilesctl set balanced ;;
"Performance") powerprofilesctl set performance ;;
esac

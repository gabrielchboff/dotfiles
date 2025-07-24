#!/bin/bash

# Qtile Desktop Environment Autostart Script
# This script launches essential desktop environment services and applications

# Wait a moment for qtile to fully load
sleep 2

# Kill any existing processes to avoid duplicates
killall -q picom
killall -q dunst
killall -q nm-applet
killall -q blueman-applet
killall -q pasystray
killall -q parcellite
killall -q flameshot
killall -q redshift
killall -q udiskie
killall -q polkit-gnome-authentication-agent-1

# ===============================
# COMPOSITOR (for transparency, shadows, animations)
# ===============================
picom --config ~/.config/picom/picom.conf --daemon &

# ===============================
# NOTIFICATION DAEMON
# ===============================
dunst &

# ===============================
# SYSTEM TRAY APPLICATIONS
# ===============================

# Network Manager Applet
nm-applet &

# Bluetooth Manager
blueman-applet &

# Audio System Tray
pasystray &

# ===============================
# DESKTOP UTILITIES
# ===============================

# Clipboard Manager
parcellite &

# Screenshot Tool
flameshot &

# Auto-mounting USB devices
udiskie --tray &

# Blue light filter
redshift -l 40.7128:-74.0060 &  # Replace with your coordinates

# ===============================
# AUTHENTICATION AGENT
# ===============================
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# ===============================
# POWER MANAGEMENT
# ===============================
xfce4-power-manager &

# ===============================
# INPUT METHODS (if needed)
# ===============================
# ibus-daemon -drx &

# ===============================
# THEME SETTINGS
# ===============================

# Set GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"

# Set Qt theme to match GTK
export QT_QPA_PLATFORMTHEME=gtk2

# ===============================
# KEYBOARD SETTINGS
# ===============================

# Set keyboard repeat rate
xset r rate 300 50

# Caps Lock as Escape (for vim users)
# setxkbmap -option caps:escape

# ===============================
# DISPLAY SETTINGS
# ===============================

# Auto-detect displays and set optimal resolution
xrandr --auto

# ===============================
# SECURITY
# ===============================

# Start firewall (if ufw is installed)
# sudo ufw --force enable

# ===============================
# OPTIONAL APPLICATIONS
# ===============================

# File manager daemon (for desktop icons and faster startup)
thunar --daemon &

# Conky system monitor (uncomment if you want it)
# conky -d

# Syncthing (file synchronization)
# syncthing -no-browser &

# Nextcloud client (uncomment if you use Nextcloud)
# nextcloud &

# Steam (gaming platform, uncomment if needed)
# steam -silent &

# Discord (uncomment if you want it to start automatically)
# discord --start-minimized &

# Spotify (uncomment if you want it to start automatically)
# spotify &

# ===============================
# CUSTOM COMMANDS
# ===============================

# Set wallpaper (fallback if qtile wallpaper setting fails)
# feh --bg-fill ~/Pictures/wallpaper.jpg &

# Custom startup script (if you have one)
if [ -f ~/.config/qtile/custom-autostart.sh ]; then
    ~/.config/qtile/custom-autostart.sh &
fi

# ===============================
# LOGGING
# ===============================
echo "Qtile autostart completed at $(date)" >> ~/.config/qtile/autostart.log

# Wait a moment for all services to start
sleep 1

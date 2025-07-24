#!/usr/bin/env bash

# Tokyo Night Storm Hyprland Setup Script
# This script installs and configures Hyprland with Tokyo Night Storm theme

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${2}${1}${NC}"
}

# Function to check if a package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
    return $?
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_message "Please do not run this script as root!" "$RED"
    exit 1
fi

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    print_message "Installing yay (AUR helper)..." "$BLUE"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Required packages
declare -a packages=(
    # Core components
    "hyprland"
    "waybar"
    "hyprpaper"
    "kitty"
    "rofi"
    "dunst"
    "xdg-utils"
    "dolphin"
    "dolphin-plugins"
    "kdeplasma-addons"
    "kde-cli-tools"
    "qt5ct"
    "qt6ct"
    "breeze"
    "breeze-icons"
    "tokyonight-gtk-theme-git"
    "ttf-jetbrainsmono-nerd"

    # Audio
    "pipewire"
    "pipewire-alsa"
    "pipewire-pulse"
    "pavucontrol"

    # Network
    "networkmanager"
    "network-manager-applet"

    # Bluetooth
    "bluez"
    "bluez-utils"
    "blueman"

    # Development tools
    "base-devel"
    "git"
    "visual-studio-code-bin"
    "brave-browser"

    # Screenshots and clipboard
    "grim"
    "slurp"
    "wl-clipboard"

    # File management
    "thunar"
    "thunar-archive-plugin"
    "file-roller"

    # System utilities
    "brightnessctl"
    "polkit-gnome"
    "qt5ct"
    "qt6ct"

    # Themes
    "ttf-jetbrains-mono-nerd"
    "noto-fonts-emoji"
    "tokyonight-gtk-theme-git"
    "papirus-icon-theme"
)

# Install packages
print_message "Installing required packages..." "$BLUE"
for package in "${packages[@]}"; do
    if ! is_installed "$package"; then
        print_message "Installing $package..." "$YELLOW"
        yay -S --noconfirm "$package"
    else
        print_message "$package is already installed." "$GREEN"
    fi
done

# Create necessary directories
print_message "Creating configuration directories..." "$BLUE"
mkdir -p ~/.config/{hypr,waybar,kitty,rofi,dunst,dolphin}
mkdir -p ~/.local/share/dolphin
mkdir -p ~/Pictures/Screenshots

# Copy configuration files
print_message "Copying configuration files..." "$BLUE"
cp -r ../* ~/.config/hypr/

# Set up component configurations
print_message "Setting up component configurations..." "$BLUE"
ln -sf ~/.config/hypr/waybar/config ~/.config/waybar/config
ln -sf ~/.config/hypr/waybar/style.css ~/.config/waybar/style.css
ln -sf ~/.config/hypr/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/.config/hypr/rofi/config.rasi ~/.config/rofi/config.rasi
ln -sf ~/.config/hypr/dunst/dunstrc ~/.config/dunst/dunstrc
ln -sf ~/.config/hypr/dolphin/dolphinrc ~/.config/dolphin/dolphinrc
ln -sf ~/.config/hypr/dolphin/kdeglobals ~/.config/kdeglobals

# Set up services
print_message "Enabling services..." "$BLUE"
systemctl --user enable pipewire.service
systemctl --user enable pipewire-pulse.service
systemctl --user enable bluetooth.service

# Create a basic wallpaper configuration
print_message "Setting up wallpaper..." "$BLUE"
echo "preload = ~/.config/hypr/wallpaper.jpg" > ~/.config/hypr/hyprpaper.conf
echo "wallpaper = ,~/.config/hypr/wallpaper.jpg" >> ~/.config/hypr/hyprpaper.conf

# Set permissions
print_message "Setting file permissions..." "$BLUE"
chmod +x ~/.config/hypr/scripts/*

# Final message
# Set GTK theme
print_message "Setting up GTK theme..." "$BLUE"
gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Storm-BL"
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font 10"

print_message "\nInstallation completed!" "$GREEN"
print_message "Please ensure to:" "$YELLOW"
print_message "1. Log out of your current session" "$YELLOW"
print_message "2. Select Hyprland from your display manager" "$YELLOW"
print_message "3. Log in to start using Hyprland" "$YELLOW"
print_message "4. Set Brave as your default browser in the system settings" "$YELLOW"
print_message "\nNote: You may need to restart your system for all changes to take effect." "$YELLOW"
print_message "\nThe Tokyo Night Storm theme has been set up for:" "$GREEN"
print_message "- Hyprland" "$BLUE"
print_message "- Waybar" "$BLUE"
print_message "- Rofi" "$BLUE"
print_message "- Kitty" "$BLUE"
print_message "- Dunst" "$BLUE"
print_message "- Dolphin" "$BLUE"
print_message "- GTK/Qt Theme" "$BLUE"

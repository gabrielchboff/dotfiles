#!/bin/bash
# Comprehensive Package Installation Script for Arch Linux
# This script installs all packages needed for your dotfiles configuration

set -e  # Exit on error

echo "=========================================="
echo "Welcome to my dotfiles installer!         "
echo "=========================================="


echo "=========================================="
echo "Installing packages for your configuration"
echo "=========================================="

echo "=========================================="
echo "Enabling multilib repository..."
echo "=========================================="

# Check if script is run as root
if [[ $EUID -eq 0 ]]; then
   echo "This script should not be run as root."
   exit 1
fi

# Backup pacman.conf
sudo cp /etc/pacman.conf /etc/pacman.conf.bak

# Function to enable multilib
enable_multilib() {
    if grep -q "^\[multilib\]$" /etc/pacman.conf && grep -q "^Include = /etc/pacman.d/mirrorlist$" /etc/pacman.conf; then
        echo "Multilib repository is already enabled."
        return 0
    fi

    # Uncomment [multilib] and Include lines
    sudo sed -i '/^\[multilib\]$/,/Include/s/^#//' /etc/pacman.conf

    if grep -q "^\[multilib\]$" /etc/pacman.conf && grep -q "^Include = /etc/pacman.d/mirrorlist$" /etc/pacman.conf; then
        echo "Multilib repository enabled successfully."
        return 0
    else
        echo "Failed to enable multilib repository."
        # Restore backup on failure
        sudo mv /etc/pacman.conf.bak /etc/pacman.conf
        return 1
    fi
}

# Run function
enable_multilib && sudo pacman -Sy


# Step 1: Install core packages from official repos
echo ""
echo "Step 1: Installing core packages from official repositories..."
echo "=========================================="

sudo pacman -S --needed --noconfirm \
    xorg-server xorg-xinit xorg-xrandr xorg-xsetroot \
    xmonad xmonad-contrib xmobar \
    alacritty \
    rofi \
    tmux \
    neovim \
    git curl wget unzip \
    gcc make cmake \
    base-devel \
    nodejs npm \
    python python-pip \
    ripgrep fd \
    ttf-jetbrains-mono-nerd \
    ttf-jetbrains-mono \
    papirus-icon-theme \
    xwallpaper \
    maim xclip \
    clipmenu \
    fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt \
    polkit-kde-agent \
    brightnessctl \
    pamixer \
    pulseaudio pulseaudio-alsa \
    thunar jdk25-openjdk\
    power-profiles-daemon \
    ghc ghc-libs haskell-xmonad-contrib \
    steam unzip \
    arandr spotify-launcher bat btop \
    yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick \
    wiremix \
    network-manager-applet \
    bluez bluez-utils blueman-manager \


echo ""
echo "Core packages installed successfully!"

# Step 2: Install paru (AUR helper)
if ! command -v paru &> /dev/null; then
    echo ""
    echo "Step 2: Installing paru (AUR helper)..."
    echo "=========================================="
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ~
    echo "paru installed successfully!"
else
    echo ""
    echo "Step 2: paru already installed, skipping..."
fi

# Step 3: Install AUR packages using paru
echo ""
echo "Step 3: Installing AUR packages with paru..."
echo "=========================================="

paru -S --needed --noconfirm \
    brave-bin \
    discord \
    heroic-games-launcher-bin \
    trayer nm-applet betterlockscreen\


betterlockscreen -u ~/wallpapers --blur 0.8

echo ""
echo "AUR packages installed successfully!"

echo "=========================================="
echo " Starting post-installation configuration..."
echo "=========================================="

# Enable and start power-profiles-daemon
echo "Enabling power-profiles-daemon..."
sudo systemctl enable --now power-profiles-daemon
echo "power-profiles-daemon enabled."

echo "=========================================="
echo "Creating mirrorlist to best suit your location..."
echo "=========================================="

# Install reflector if not installed
if ! command -v reflector &> /dev/null; then
  echo "Installing reflector..."
  sudo pacman -S --noconfirm reflector
fi

# Create mirrorlist
echo "Generating mirrorlist..."
# Getting top 10 fastest mirrors
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
echo "Mirrorlist generated."

echo "Bluetooth setup..."
# Enable and start bluetooth service
sudo systemctl enable --now bluetooth
echo "Bluetooth service enabled and started."


echo "===================================================="
echo " Copying configuration files to the config folder..."
echo "===================================================="

# Create config directory if it doesn't exist
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

# Copy dotfiles configuration (assuming dotfiles are in ~/dotfiles)
cp -r $HOME/dotfiles/rofi $CONFIG_DIR
cp -r $HOME/dotfiles/alacritty $CONFIG_DIR
cp -r $HOME/dotfiles/xmobar $CONFIG_DIR
cp -r $HOME/dotfiles/xmonad $CONFIG_DIR
cp -r $HOME/dotfiles/nvim $CONFIG_DIR
cp -r $HOME/dotfiles/tmux $CONFIG_DIR

echo "Configuration files copied successfully!"

echo "=========================================="
echo "Building xmonad..."
echo "=========================================="

echo "Copying wallpapers..."
# Create wallpapers directory if it doesn't exist
WALLPAPER_DIR="$HOME/wallpapers"
mkdir -p "$WALLPAPER_DIR"
cp -r ./wallpapers/* "$WALLPAPER_DIR/"
echo "Wallpapers copied successfully!"

# Build xmonad
# Ensure xmonad is built
xmonad --recompile || {
    echo "Xmonad build failed. Please check for errors."
    exit 1
}

echo "Xmonad built successfully!"

# Restarting Xmonad
echo "Restarting Xmonad..."
xmonad --restart || {
    echo "Failed to restart Xmonad. Please restart it manually."
    exit 1
}

echo "Xmonad restarted successfully!"

echo "=================================================="
echo "Installation and configuration complete!"
echo "Please restart your computer to apply all changes."
echo "=================================================="

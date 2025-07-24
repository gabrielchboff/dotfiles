#!/bin/bash

# ===============================
# Qtile Desktop Environment Dependencies Installer
# For Arch Linux and Arch-based distributions
# ===============================

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_section() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${CYAN}→ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_section "Qtile Desktop Environment Dependencies Installer"

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    print_error "This script is designed for Arch Linux and Arch-based distributions"
    exit 1
fi

# Update system first
print_section "Updating System"
sudo pacman -Syu --noconfirm
print_success "System updated"

# Install core development tools and dependencies
print_section "Installing Core Development Tools"
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    python3 \
    python-pip \
    python-psutil \
    python-iwlib \
    python-dbus-next \
    python-lsp-server \
    clang \
    unzip \
    curl \
    wget \
    xdg-user-dirs \
    pacman-contrib
print_success "Core development tools installed"

# Install Qtile and Python dependencies
print_section "Installing Qtile and Dependencies"
sudo pacman -S --needed --noconfirm \
    qtile \
    python-psutil \
    python-iwlib \
    python-dbus-next \
    python-xcffib \
    python-cairocffi
print_success "Qtile installed"

# Install X11 and display server components
print_section "Installing X11 Components"
sudo pacman -S --needed --noconfirm \
    xorg-server \
    xorg-xinit \
    xorg-xrandr \
    xorg-xset \
    xorg-setxkbmap \
    xorg-xprop \
    xorg-xwininfo \
    xorg-xev
print_success "X11 components installed"

# Install desktop environment core components
print_section "Installing Desktop Environment Components"
sudo pacman -S --needed --noconfirm \
    picom \
    dunst \
    rofi \
    feh \
    nitrogen \
    arandr \
    lxappearance \
    qt5ct
print_success "Desktop environment components installed"

# Install terminal and essential applications
print_section "Installing Terminal and Applications"
sudo pacman -S --needed --noconfirm \
    alacritty \
    kitty \
    firefox \
    thunar \
    thunar-volman \
    thunar-archive-plugin \
    file-roller \
    code \
    neovim \
    vim
print_success "Terminal and applications installed"

# Install system tray and system management tools
print_section "Installing System Tray Applications"
sudo pacman -S --needed --noconfirm \
    network-manager-applet \
    bluez \
    bluez-utils \
    blueman \
    pulseaudio \
    pulseaudio-alsa \
    pavucontrol \
    pasystray \
    xfce4-power-manager \
    polkit-gnome
print_success "System tray applications installed"

# Install utilities and tools
print_section "Installing System Utilities"
sudo pacman -S --needed --noconfirm \
    flameshot \
    parcellite \
    udiskie \
    redshift \
    brightnessctl \
    playerctl \
    pamixer \
    maim \
    xclip \
    imagemagick \
    htop \
    neofetch \
    ranger \
    calcurse \
    qalculate-gtk
print_success "System utilities installed"

# Install media and file handling
print_section "Installing Media and File Tools"
sudo pacman -S --needed --noconfirm \
    vlc \
    mpv \
    feh \
    sxiv \
    p7zip \
    unrar \
    tar \
    rsync \
    exfat-utils \
    ntfs-3g \
    gvfs \
    gvfs-mtp
print_success "Media and file tools installed"

# Install fonts
print_section "Installing Fonts"
sudo pacman -S --needed --noconfirm \
    ttf-jetbrains-mono \
    ttf-font-awesome \
    ttf-fira-code \
    ttf-liberation \
    ttf-dejavu \
    ttf-ubuntu-font-family \
    ttf-anonymous-pro \
    noto-fonts \
    noto-fonts-emoji \
    adobe-source-sans-pro-fonts
print_success "Fonts installed"

# Install shell enhancements
print_section "Installing Shell Enhancements"
sudo pacman -S --needed --noconfirm \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    tmux \
    stow
print_success "Shell enhancements installed"

# Install additional development tools
print_section "Installing Additional Development Tools"
sudo pacman -S --needed --noconfirm \
    jre8-openjdk \
    jdk-openjdk \
    nodejs \
    npm \
    go \
    rust \
    docker \
    docker-compose
print_success "Development tools installed"

# Install themes and appearance
print_section "Installing Themes and Icons"
sudo pacman -S --needed --noconfirm \
    arc-gtk-theme \
    papirus-icon-theme \
    materia-gtk-theme
print_success "Themes and icons installed"

# Install security and system tools
print_section "Installing Security Tools"
sudo pacman -S --needed --noconfirm \
    ufw \
    reflector \
    timeshift \
    pkgstats
print_success "Security tools installed"

# Install AUR helper (yay) if not already installed
print_section "Installing AUR Helper (yay)"
if ! command -v yay &> /dev/null; then
    print_info "Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay-git.git
    cd yay-git
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay-git
    print_success "yay installed"
else
    print_success "yay already installed"
fi

# Update yay and install AUR packages
print_section "Installing AUR Packages"
yay -Syu --noconfirm

# Install essential AUR packages
yay -S --needed --noconfirm \
    ttf-jetbrains-mono-nerd \
    nerd-fonts-jetbrains-mono \
    picom-ibhagwan-git \
    betterlockscreen \
    rofi-greenclip \
    catppuccin-gtk-theme-mocha \
    bibata-cursor-theme \
    preload
print_success "AUR packages installed"

# Enable and start essential services
print_section "Enabling System Services"
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable ufw
sudo systemctl enable preload
sudo systemctl start NetworkManager
sudo systemctl start bluetooth
sudo ufw enable
sudo systemctl start preload
print_success "System services enabled"

# Create necessary directories
print_section "Creating Configuration Directories"
mkdir -p ~/.config/{qtile,picom,rofi,dunst,alacritty,nvim}
mkdir -p ~/.local/share/fonts
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Documents/git-lab
print_success "Configuration directories created"

# Install Oh My Zsh
print_section "Installing Oh My Zsh"
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_success "Oh My Zsh already installed"
fi

# Set up user directories
print_section "Setting Up User Directories"
xdg-user-dirs-update
print_success "User directories updated"

# Refresh font cache
print_section "Refreshing Font Cache"
fc-cache -fv
print_success "Font cache refreshed"

# Set up firewall
print_section "Configuring Firewall"
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw status verbose
print_success "Firewall configured"

print_section "Installation Complete!"
echo -e "${GREEN}✓ All dependencies have been successfully installed!${NC}"
echo -e "${CYAN}→ Next steps:${NC}"
echo -e "  1. Copy qtile configuration: cp -r ../qtile ~/.config/"
echo -e "  2. Copy other configs: cp -r ../{picom,rofi} ~/.config/"
echo -e "  3. Restart your system or log out and select Qtile"
echo -e "  4. Run autostart script: ~/.config/qtile/autostart.sh"
echo -e "${YELLOW}⚠ Don't forget to add a wallpaper to ~/Pictures/wallpaper.jpg${NC}"

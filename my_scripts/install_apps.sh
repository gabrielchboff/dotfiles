#!/bin/bash

# ===============================
# Qtile Desktop Environment Applications Installer
# Additional applications and tools for a complete desktop experience
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

# Check if yay is installed
check_yay() {
    if ! command -v yay &> /dev/null; then
        print_error "yay AUR helper is not installed. Please run install_dependencies.sh first."
        exit 1
    fi
}

print_section "Qtile Desktop Environment Applications Installer"

# Check prerequisites
check_yay

# Update system and AUR packages
print_section "Updating System and AUR Packages"
sudo pacman -Syu --noconfirm
yay -Syu --noconfirm
print_success "System updated"

# Install productivity applications
print_section "Installing Productivity Applications"
sudo pacman -S --needed --noconfirm \
    libreoffice-fresh \
    thunderbird \
    keepassxc \
    obsidian \
    notion-app \
    typora \
    zathura \
    zathura-pdf-mupdf \
    calibre \
    foliate
print_success "Productivity applications installed"

# Install media applications
print_section "Installing Media Applications"
sudo pacman -S --needed --noconfirm \
    vlc \
    mpv \
    audacity \
    kdenlive \
    obs-studio \
    gimp \
    krita \
    inkscape \
    blender \
    darktable \
    shotcut
print_success "Media applications installed"

# Install development tools
print_section "Installing Development Tools"
sudo pacman -S --needed --noconfirm \
    docker \
    docker-compose \
    podman \
    tmux \
    stow \
    github-cli \
    lazygit \
    postman-bin \
    insomnia \
    dbeaver \
    mongodb-compass
print_success "Development tools installed"

# Install system monitoring and utilities
print_section "Installing System Utilities"
sudo pacman -S --needed --noconfirm \
    neofetch \
    htop \
    btop \
    iotop \
    nload \
    tree \
    fd \
    ripgrep \
    fzf \
    bat \
    exa \
    zoxide \
    dust \
    procs \
    bandwhich \
    bottom
print_success "System utilities installed"

# Install security and backup tools
print_section "Installing Security and Backup Tools"
sudo pacman -S --needed --noconfirm \
    ufw \
    reflector \
    timeshift \
    rsync \
    rclone \
    borgbackup \
    veracrypt \
    clamav \
    lynis
print_success "Security and backup tools installed"

# Install communication and social applications
print_section "Installing Communication Applications"
yay -S --needed --noconfirm \
    discord \
    slack-desktop \
    zoom \
    teams \
    telegram-desktop \
    signal-desktop \
    whatsapp-for-linux \
    element-desktop
print_success "Communication applications installed"

# Install gaming and entertainment
print_section "Installing Gaming and Entertainment"
yay -S --needed --noconfirm \
    steam \
    lutris \
    heroic-games-launcher-bin \
    gamemode \
    mangohud \
    spotify \
    spotify-adblock-git \
    youtube-dl \
    yt-dlp \
    freetube-bin
print_success "Gaming and entertainment applications installed"

# Install web browsers
print_section "Installing Web Browsers"
yay -S --needed --noconfirm \
    brave-bin \
    google-chrome \
    opera \
    vivaldi \
    librewolf-bin
print_success "Web browsers installed"

# Install file managers and archive tools
print_section "Installing File Management Tools"
sudo pacman -S --needed --noconfirm \
    dolphin \
    nautilus \
    pcmanfm \
    ranger \
    nnn \
    mc \
    ark \
    xarchiver \
    unzip \
    zip \
    p7zip \
    unrar \
    cabextract
print_success "File management tools installed"

# Install fonts and themes
print_section "Installing Additional Fonts and Themes"
yay -S --needed --noconfirm \
    nerd-fonts-complete \
    ttf-ms-fonts \
    ttf-vista-fonts \
    apple-fonts \
    nordic-theme \
    sweet-theme-git \
    whitesur-gtk-theme-git \
    tela-icon-theme \
    beautyline
print_success "Additional fonts and themes installed"

# Install virtualization tools
print_section "Installing Virtualization Tools"
sudo pacman -S --needed --noconfirm \
    qemu-full \
    virt-manager \
    libvirt \
    edk2-ovmf \
    iptables-nft \
    dnsmasq \
    bridge-utils \
    openbsd-netcat
print_success "Virtualization tools installed"

# Install network tools
print_section "Installing Network Tools"
sudo pacman -S --needed --noconfirm \
    wireshark-qt \
    nmap \
    netcat \
    tcpdump \
    iperf3 \
    speedtest-cli \
    nethogs \
    vnstat \
    wavemon \
    wireless_tools
print_success "Network tools installed"

# Install qtile-specific enhancements
print_section "Installing Qtile-Specific Enhancements"
yay -S --needed --noconfirm \
    qtile-extras \
    python-psutil \
    python-iwlib \
    python-keyring \
    python-secretstorage \
    python-pulsectl \
    python-pynvim \
    conky \
    polybar \
    eww-git
print_success "Qtile enhancements installed"

# Install terminal emulators and tools
print_section "Installing Terminal Tools"
yay -S --needed --noconfirm \
    wezterm \
    terminator \
    tilix \
    starship \
    oh-my-posh-bin \
    powerlevel10k \
    tmux-plugin-manager
print_success "Terminal tools installed"

# Install cloud and sync tools
print_section "Installing Cloud and Sync Tools"
yay -S --needed --noconfirm \
    dropbox \
    google-drive-ocamlfuse \
    nextcloud-client \
    syncthing \
    onedrive-abraunegg \
    pcloud-drive \
    mega-sync-bin
print_success "Cloud and sync tools installed"

# Enable and configure services
print_section "Configuring System Services"

# Enable Docker
print_info "Enabling Docker service..."
sudo systemctl enable docker
sudo usermod -aG docker $USER
print_success "Docker configured"

# Enable UFW Firewall
print_info "Configuring UFW firewall..."
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw status verbose
print_success "UFW firewall configured"

# Enable Preload for faster application startup
print_info "Enabling preload service..."
sudo systemctl enable preload
sudo systemctl start preload
print_success "Preload service enabled"

# Enable libvirt for virtualization
print_info "Enabling libvirt service..."
sudo systemctl enable libvirtd
sudo usermod -aG libvirt $USER
print_success "Libvirt configured"

# Enable syncthing for file synchronization
print_info "Enabling syncthing service..."
systemctl --user enable syncthing
print_success "Syncthing enabled"

# Configure ClamAV antivirus
print_info "Configuring ClamAV antivirus..."
sudo freshclam
sudo systemctl enable clamav-freshclam
print_success "ClamAV configured"

# Create additional directories
print_section "Creating Additional Directories"
mkdir -p ~/Documents/{Projects,Scripts,Templates}
mkdir -p ~/Downloads/{Software,Documents,Media}
mkdir -p ~/Pictures/{Screenshots,Wallpapers,Photos}
mkdir -p ~/Videos/{Recordings,Projects}
mkdir -p ~/Music/Playlists
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
print_success "Additional directories created"

# Set up gaming optimizations
print_section "Setting Up Gaming Optimizations"
print_info "Configuring gaming optimizations..."

# Add gamemode configuration
sudo tee /etc/security/limits.conf > /dev/null <<EOF
@games soft nofile 524288
@games hard nofile 1048576
EOF

# Create games group and add user
sudo groupadd -f games
sudo usermod -aG games $USER

print_success "Gaming optimizations configured"

# Configure additional system settings
print_section "Configuring System Settings"

# Configure reflector for fastest mirrors
print_info "Configuring reflector..."
sudo tee /etc/xdg/reflector/reflector.conf > /dev/null <<EOF
--save /etc/pacman.d/mirrorlist
--protocol https
--country Germany,Netherlands,France
--latest 10
--sort rate
EOF

sudo systemctl enable reflector.timer
print_success "Reflector configured"

# Configure timeshift for system backups
print_info "Setting up timeshift backup..."
sudo timeshift --create --comments "Initial system backup after application installation"
print_success "Timeshift backup created"

# Final system optimization
print_section "Final System Optimization"

# Update desktop database
print_info "Updating desktop database..."
update-desktop-database ~/.local/share/applications/

# Update MIME database
print_info "Updating MIME database..."
update-mime-database ~/.local/share/mime/

# Update icon cache
print_info "Updating icon cache..."
gtk-update-icon-cache -f ~/.local/share/icons/ 2>/dev/null || true

# Update font cache
print_info "Updating font cache..."
fc-cache -fv

print_success "System optimization completed"

print_section "Installation Complete!"
echo -e "${GREEN}✓ All applications have been successfully installed!${NC}"
echo -e "${CYAN}→ Installed application categories:${NC}"
echo -e "  • Productivity: LibreOffice, Obsidian, KeePassXC"
echo -e "  • Media: VLC, GIMP, Krita, Kdenlive, OBS Studio"
echo -e "  • Development: Docker, VS Code, Postman, DBeaver"
echo -e "  • Communication: Discord, Slack, Zoom, Telegram"
echo -e "  • Gaming: Steam, Lutris, Heroic Games Launcher"
echo -e "  • Browsers: Brave, Chrome, Firefox, LibreWolf"
echo -e "  • System Tools: Timeshift, UFW, ClamAV, Preload"

echo -e "\n${YELLOW}⚠ Important Notes:${NC}"
echo -e "  • Docker and libvirt groups have been added to your user"
echo -e "  • UFW firewall has been enabled with default rules"
echo -e "  • Preload service enabled for faster app startup"
echo -e "  • System backup created with timeshift"
echo -e "  • Please reboot to apply all group changes"

echo -e "\n${PURPLE}🎮 Gaming Setup:${NC}"
echo -e "  • Run 'gamemoderun <game>' for optimized performance"
echo -e "  • Use MangoHud for FPS monitoring: 'mangohud <game>'"
echo -e "  • Steam and Lutris are ready for gaming"

echo -e "\n${BLUE}🔧 Next Steps:${NC}"
echo -e "  1. Reboot your system: sudo reboot"
echo -e "  2. Configure your applications"
echo -e "  3. Set up cloud sync services"
echo -e "  4. Enjoy your complete qtile desktop environment!"

print_success "All applications installed successfully!"

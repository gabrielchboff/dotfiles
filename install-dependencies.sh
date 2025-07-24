#!/bin/bash

# ===============================
# Qtile Desktop Environment Dependency Installer
# ===============================
# This script automatically detects your Linux distribution and installs
# all necessary dependencies for the qtile desktop environment configuration.

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Unicode symbols
CHECK_MARK="✓"
CROSS_MARK="✗"
ARROW="→"
STAR="★"

# ===============================
# HELPER FUNCTIONS
# ===============================

print_header() {
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}               ${CYAN}Qtile Desktop Environment Installer${NC}               ${PURPLE}║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
}

print_section() {
    echo -e "\n${BLUE}${STAR} $1${NC}"
    echo -e "${BLUE}$(printf '=%.0s' {1..60})${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK_MARK} $1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS_MARK} $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${CYAN}${ARROW} $1${NC}"
}

# Function to detect Linux distribution
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
    elif [[ -f /etc/arch-release ]]; then
        DISTRO="arch"
    elif [[ -f /etc/debian_version ]]; then
        DISTRO="debian"
    elif [[ -f /etc/redhat-release ]]; then
        DISTRO="fedora"
    else
        DISTRO="unknown"
    fi

    echo $DISTRO
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if package is installed
is_installed() {
    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            pacman -Qi "$1" >/dev/null 2>&1
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            dpkg -l "$1" >/dev/null 2>&1
            ;;
        "fedora"|"centos"|"rhel")
            rpm -q "$1" >/dev/null 2>&1
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to install packages based on distribution
install_packages() {
    local packages=("$@")

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            print_info "Installing packages with pacman..."
            sudo pacman -S --needed --noconfirm "${packages[@]}" 2>/dev/null || {
                print_warning "Some packages might not be available in official repos"
            }
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            print_info "Updating package database..."
            sudo apt update -qq
            print_info "Installing packages with apt..."
            sudo apt install -y "${packages[@]}" 2>/dev/null || {
                print_warning "Some packages might not be available"
            }
            ;;
        "fedora"|"centos"|"rhel")
            print_info "Installing packages with dnf..."
            sudo dnf install -y "${packages[@]}" 2>/dev/null || {
                print_warning "Some packages might not be available"
            }
            ;;
        *)
            print_error "Unsupported distribution: $DISTRO"
            return 1
            ;;
    esac
}

# Function to install AUR packages (Arch-based only)
install_aur_packages() {
    local packages=("$@")

    if [[ ! "$DISTRO" =~ ^(arch|manjaro|endeavouros)$ ]]; then
        return 0
    fi

    # Check if yay is installed
    if ! command_exists yay; then
        print_info "Installing yay AUR helper..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd - >/dev/null
        rm -rf /tmp/yay
    fi

    print_info "Installing AUR packages with yay..."
    yay -S --needed --noconfirm "${packages[@]}" 2>/dev/null || {
        print_warning "Some AUR packages might not be available"
    }
}

# ===============================
# MAIN INSTALLATION FUNCTIONS
# ===============================

install_core_qtile() {
    print_section "Installing Core Qtile Packages"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "qtile"
                "python-psutil"
                "python-iwlib"
                "python-dbus-next"
            )
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "qtile"
                "python3-psutil"
                "python3-iwlib"
                "python3-dbus"
            )
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "qtile"
                "python3-psutil"
                "python3-dbus"
            )
            ;;
    esac

    install_packages "${packages[@]}"
    print_success "Core Qtile packages installed"
}

install_terminal_and_apps() {
    print_section "Installing Terminal and Essential Applications"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "alacritty"
                "firefox"
                "code"
                "thunar"
                "thunar-volman"
                "thunar-archive-plugin"
                "file-roller"
            )
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "alacritty"
                "firefox"
                "code"
                "thunar"
                "thunar-volman"
                "thunar-archive-plugin"
                "file-roller"
            )
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "alacritty"
                "firefox"
                "code"
                "thunar"
                "file-roller"
            )
            ;;
    esac

    install_packages "${packages[@]}"
    print_success "Terminal and applications installed"
}

install_desktop_environment() {
    print_section "Installing Desktop Environment Components"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "picom"
                "dunst"
                "rofi"
                "feh"
                "xorg-xrandr"
                "xorg-xset"
                "xorg-setxkbmap"
            )
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "picom"
                "dunst"
                "rofi"
                "feh"
                "x11-xserver-utils"
            )
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "picom"
                "dunst"
                "rofi"
                "feh"
                "xorg-x11-server-utils"
            )
            ;;
    esac

    install_packages "${packages[@]}"
    print_success "Desktop environment components installed"
}

install_system_tray() {
    print_section "Installing System Tray Applications"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "network-manager-applet"
                "blueman"
                "pasystray"
                "pavucontrol"
                "pulseaudio"
                "pulseaudio-alsa"
            )
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "network-manager-gnome"
                "blueman"
                "pasystray"
                "pavucontrol"
                "pulseaudio"
                "pulseaudio-utils"
            )
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "network-manager-applet"
                "blueman"
                "pavucontrol"
                "pulseaudio"
                "pulseaudio-utils"
            )
            ;;
    esac

    install_packages "${packages[@]}"
    print_success "System tray applications installed"
}

install_utilities() {
    print_section "Installing Desktop Utilities"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "flameshot"
                "parcellite"
                "udiskie"
                "redshift"
                "brightnessctl"
                "playerctl"
                "xfce4-power-manager"
                "polkit-gnome"
                "arandr"
                "lxappearance"
                "qt5ct"
            )
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "flameshot"
                "parcellite"
                "udiskie"
                "redshift"
                "brightnessctl"
                "playerctl"
                "xfce4-power-manager"
                "policykit-1-gnome"
                "arandr"
                "lxappearance"
                "qt5ct"
            )
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "flameshot"
                "parcellite"
                "redshift"
                "playerctl"
                "xfce4-power-manager"
                "polkit-gnome"
                "arandr"
                "lxappearance"
                "qt5ct"
            )
            ;;
    esac

    install_packages "${packages[@]}"
    print_success "Desktop utilities installed"
}

install_fonts() {
    print_section "Installing Fonts"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "ttf-jetbrains-mono-nerd"
                "ttf-nerd-fonts-symbols"
                "ttf-font-awesome"
                "ttf-fira-code"
                "noto-fonts"
                "noto-fonts-emoji"
            )
            install_packages "${packages[@]}"

            # Install additional nerd fonts from AUR
            local aur_packages=(
                "nerd-fonts-jetbrains-mono"
                "nerd-fonts-fira-code"
            )
            install_aur_packages "${aur_packages[@]}"
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "fonts-jetbrains-mono"
                "fonts-font-awesome"
                "fonts-firacode"
                "fonts-noto"
                "fonts-noto-color-emoji"
            )
            install_packages "${packages[@]}"

            # Install Nerd Fonts manually for Debian-based
            print_info "Installing Nerd Fonts manually..."
            mkdir -p ~/.local/share/fonts
            cd /tmp
            wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
            unzip -q JetBrainsMono.zip -d ~/.local/share/fonts/
            rm JetBrainsMono.zip
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "jetbrains-mono-fonts"
                "fontawesome-fonts"
                "fira-code-fonts"
                "google-noto-fonts"
                "google-noto-emoji-fonts"
            )
            install_packages "${packages[@]}"

            # Install Nerd Fonts manually for Fedora
            print_info "Installing Nerd Fonts manually..."
            mkdir -p ~/.local/share/fonts
            cd /tmp
            wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
            unzip -q JetBrainsMono.zip -d ~/.local/share/fonts/
            rm JetBrainsMono.zip
            ;;
    esac

    # Refresh font cache
    fc-cache -fv >/dev/null 2>&1
    print_success "Fonts installed and cache refreshed"
}

install_themes() {
    print_section "Installing Themes and Icons"

    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            local packages=(
                "papirus-icon-theme"
                "arc-gtk-theme"
                "materia-gtk-theme"
            )
            install_packages "${packages[@]}"

            local aur_packages=(
                "bibata-cursor-theme"
                "catppuccin-gtk-theme-mocha"
            )
            install_aur_packages "${aur_packages[@]}"
            ;;
        "ubuntu"|"debian"|"pop"|"elementary")
            local packages=(
                "papirus-icon-theme"
                "arc-theme"
                "materia-gtk-theme"
            )
            install_packages "${packages[@]}"
            ;;
        "fedora"|"centos"|"rhel")
            local packages=(
                "papirus-icon-theme"
                "arc-theme"
            )
            install_packages "${packages[@]}"
            ;;
    esac

    print_success "Themes and icons installed"
}

install_optional_apps() {
    print_section "Installing Optional Applications"

    echo -e "${YELLOW}The following applications are optional but recommended:${NC}"
    echo "1. Discord - Communication"
    echo "2. Spotify - Music streaming"
    echo "3. GIMP - Image editing"
    echo "4. VLC - Media player"
    echo "5. LibreOffice - Office suite"
    echo "6. Calculator (qalculate-gtk)"

    read -p "Do you want to install optional applications? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        case $DISTRO in
            "arch"|"manjaro"|"endeavouros")
                local packages=(
                    "discord"
                    "gimp"
                    "vlc"
                    "libreoffice-fresh"
                    "qalculate-gtk"
                )
                install_packages "${packages[@]}"

                # Spotify from AUR
                install_aur_packages "spotify"
                ;;
            "ubuntu"|"debian"|"pop"|"elementary")
                local packages=(
                    "gimp"
                    "vlc"
                    "libreoffice"
                    "qalculate-gtk"
                )
                install_packages "${packages[@]}"

                # Install Discord and Spotify via snap
                if command_exists snap; then
                    sudo snap install discord
                    sudo snap install spotify
                fi
                ;;
            "fedora"|"centos"|"rhel")
                local packages=(
                    "gimp"
                    "vlc"
                    "libreoffice"
                    "qalculate-gtk"
                )
                install_packages "${packages[@]}"
                ;;
        esac
        print_success "Optional applications installed"
    else
        print_info "Skipping optional applications"
    fi
}

install_development_tools() {
    print_section "Installing Development Tools"

    read -p "Do you want to install development tools? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        case $DISTRO in
            "arch"|"manjaro"|"endeavouros")
                local packages=(
                    "git"
                    "vim"
                    "neovim"
                    "base-devel"
                    "python-pip"
                    "nodejs"
                    "npm"
                )
                ;;
            "ubuntu"|"debian"|"pop"|"elementary")
                local packages=(
                    "git"
                    "vim"
                    "neovim"
                    "build-essential"
                    "python3-pip"
                    "nodejs"
                    "npm"
                )
                ;;
            "fedora"|"centos"|"rhel")
                local packages=(
                    "git"
                    "vim"
                    "neovim"
                    "gcc"
                    "make"
                    "python3-pip"
                    "nodejs"
                    "npm"
                )
                ;;
        esac

        install_packages "${packages[@]}"
        print_success "Development tools installed"
    else
        print_info "Skipping development tools"
    fi
}

setup_services() {
    print_section "Setting up System Services"

    # Enable NetworkManager
    if systemctl is-enabled NetworkManager >/dev/null 2>&1; then
        print_info "NetworkManager already enabled"
    else
        sudo systemctl enable NetworkManager
        print_success "NetworkManager enabled"
    fi

    # Enable Bluetooth
    if systemctl is-enabled bluetooth >/dev/null 2>&1; then
        print_info "Bluetooth already enabled"
    else
        sudo systemctl enable bluetooth
        print_success "Bluetooth enabled"
    fi

    # Enable audio service
    case $DISTRO in
        "arch"|"manjaro"|"endeavouros")
            systemctl --user enable pulseaudio >/dev/null 2>&1 || true
            ;;
        "ubuntu"|"debian"|"pop"|"elementary"|"fedora"|"centos"|"rhel")
            # PulseAudio usually starts automatically
            ;;
    esac

    print_success "System services configured"
}

create_directories() {
    print_section "Creating Required Directories"

    local directories=(
        "$HOME/.config"
        "$HOME/.config/qtile"
        "$HOME/.config/picom"
        "$HOME/.config/rofi"
        "$HOME/.config/dunst"
        "$HOME/.local/share/fonts"
        "$HOME/Pictures"
        "$HOME/.cache/rofi"
    )

    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
        print_info "Created directory: $dir"
    done

    print_success "Required directories created"
}

final_setup() {
    print_section "Final Setup Steps"

    print_info "Setting up configuration permissions..."
    if [[ -f "$HOME/.config/qtile/autostart.sh" ]]; then
        chmod +x "$HOME/.config/qtile/autostart.sh"
        print_success "Made autostart.sh executable"
    fi

    print_info "Setting default applications..."

    # Set default browser
    if command_exists firefox; then
        xdg-settings set default-web-browser firefox.desktop 2>/dev/null || true
    fi

    # Set default file manager
    if command_exists thunar; then
        xdg-mime default thunar.desktop inode/directory 2>/dev/null || true
    fi

    print_success "Final setup completed"
}

print_completion_message() {
    print_section "Installation Complete!"

    echo -e "${GREEN}${CHECK_MARK} All dependencies have been successfully installed!${NC}\n"

    echo -e "${CYAN}Next steps:${NC}"
    echo -e "${ARROW} Copy the qtile configuration to ~/.config/qtile/"
    echo -e "${ARROW} Add a wallpaper to ~/Pictures/wallpaper.jpg"
    echo -e "${ARROW} Log out and select Qtile from your display manager"
    echo -e "${ARROW} Or start qtile with: startx qtile start"

    echo -e "\n${YELLOW}Useful commands:${NC}"
    echo -e "${ARROW} Super + D: Application launcher"
    echo -e "${ARROW} Super + Return: Terminal"
    echo -e "${ARROW} Super + E: File manager"
    echo -e "${ARROW} Super + Ctrl + C: Reload qtile config"

    echo -e "\n${PURPLE}Configuration files location:${NC}"
    echo -e "${ARROW} ~/.config/qtile/config.py"
    echo -e "${ARROW} ~/.config/picom/picom.conf"
    echo -e "${ARROW} ~/.config/rofi/config.rasi"

    echo -e "\n${GREEN}Enjoy your new Qtile desktop environment! ${STAR}${NC}\n"
}

# ===============================
# MAIN EXECUTION
# ===============================

main() {
    print_header

    # Check if running as root
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root"
        exit 1
    fi

    # Detect distribution
    DISTRO=$(detect_distro)
    print_info "Detected distribution: $DISTRO"

    if [[ "$DISTRO" == "unknown" ]]; then
        print_error "Unsupported Linux distribution"
        exit 1
    fi

    # Check for sudo access
    if ! sudo -n true 2>/dev/null; then
        print_info "This script requires sudo access for package installation"
        sudo -v
    fi

    # Run installation steps
    install_core_qtile
    install_terminal_and_apps
    install_desktop_environment
    install_system_tray
    install_utilities
    install_fonts
    install_themes
    install_optional_apps
    install_development_tools
    setup_services
    create_directories
    final_setup

    print_completion_message
}

# Handle script interruption
trap 'echo -e "\n${RED}Installation interrupted!${NC}"; exit 1' INT

# Run main function
main "$@"

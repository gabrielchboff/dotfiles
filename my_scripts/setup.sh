#!/bin/bash

# ===============================
# Qtile Desktop Environment Setup Script
# Complete installation and configuration coordinator
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

# Unicode symbols
CHECK_MARK="✓"
CROSS_MARK="✗"
ARROW="→"
STAR="★"
ROCKET="🚀"
GEAR="⚙"

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# ===============================
# HELPER FUNCTIONS
# ===============================

print_header() {
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}             ${CYAN}${ROCKET} Qtile Desktop Environment Setup ${ROCKET}${NC}             ${PURPLE}║${NC}"
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

print_step() {
    echo -e "${PURPLE}${GEAR} $1${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to backup existing configurations
backup_configs() {
    local backup_dir="$HOME/.config/backup-$(date +%Y%m%d-%H%M%S)"

    print_step "Creating backup of existing configurations..."

    if [[ -d "$HOME/.config/qtile" ]] || [[ -d "$HOME/.config/picom" ]] || [[ -d "$HOME/.config/rofi" ]]; then
        mkdir -p "$backup_dir"

        [[ -d "$HOME/.config/qtile" ]] && mv "$HOME/.config/qtile" "$backup_dir/"
        [[ -d "$HOME/.config/picom" ]] && mv "$HOME/.config/picom" "$backup_dir/"
        [[ -d "$HOME/.config/rofi" ]] && mv "$HOME/.config/rofi" "$backup_dir/"
        [[ -d "$HOME/.config/nvim" ]] && mv "$HOME/.config/nvim" "$backup_dir/"
        [[ -f "$HOME/.tmux.conf" ]] && mv "$HOME/.tmux.conf" "$backup_dir/"

        print_success "Existing configurations backed up to: $backup_dir"
    else
        print_info "No existing configurations found to backup"
    fi
}

# Function to copy configurations
copy_configurations() {
    print_step "Copying qtile desktop environment configurations..."

    # Create necessary directories
    mkdir -p ~/.config/{qtile,picom,rofi,dunst,alacritty,nvim}
    mkdir -p ~/.local/share/fonts
    mkdir -p ~/Pictures/Screenshots

    # Copy qtile configuration
    if [[ -d "$DOTFILES_DIR/qtile" ]]; then
        cp -r "$DOTFILES_DIR/qtile"/* ~/.config/qtile/
        chmod +x ~/.config/qtile/autostart.sh
        print_success "Qtile configuration copied"
    else
        print_error "Qtile configuration directory not found!"
        return 1
    fi

    # Copy picom configuration
    if [[ -d "$DOTFILES_DIR/picom" ]]; then
        cp -r "$DOTFILES_DIR/picom"/* ~/.config/picom/
        print_success "Picom configuration copied"
    else
        print_warning "Picom configuration not found, using defaults"
    fi

    # Copy rofi configuration
    if [[ -d "$DOTFILES_DIR/rofi" ]]; then
        cp -r "$DOTFILES_DIR/rofi"/* ~/.config/rofi/
        print_success "Rofi configuration copied"
    else
        print_warning "Rofi configuration not found, using defaults"
    fi

    # Copy neovim configuration
    if [[ -d "$DOTFILES_DIR/nvim" ]]; then
        cp -r "$DOTFILES_DIR/nvim"/* ~/.config/nvim/
        print_success "Neovim configuration copied"
    else
        print_info "Neovim configuration not found, skipping"
    fi

    # Copy tmux configuration
    if [[ -f "$DOTFILES_DIR/.tmux.conf" ]]; then
        cp "$DOTFILES_DIR/.tmux.conf" ~/
        print_success "Tmux configuration copied"
    else
        print_info "Tmux configuration not found, skipping"
    fi

    # Copy main autostart script
    if [[ -f "$DOTFILES_DIR/autostart.sh" ]]; then
        cp "$DOTFILES_DIR/autostart.sh" ~/.config/qtile/
        chmod +x ~/.config/qtile/autostart.sh
        print_success "Main autostart script copied"
    fi
}

# Function to set up wallpaper
setup_wallpaper() {
    print_step "Setting up wallpaper directory..."

    mkdir -p ~/Pictures/Wallpapers

    # Create a default wallpaper if none exists
    if [[ ! -f ~/Pictures/wallpaper.jpg ]]; then
        print_info "No wallpaper found, you can add one later to ~/Pictures/wallpaper.jpg"
        # Create a simple colored background as fallback
        if command_exists convert; then
            convert -size 1920x1080 xc:'#1e1e2e' ~/Pictures/wallpaper.jpg
            print_success "Created default Catppuccin-colored wallpaper"
        fi
    else
        print_success "Wallpaper already exists"
    fi
}

# Function to set up fonts
setup_fonts() {
    print_step "Setting up fonts..."

    # Refresh font cache
    if command_exists fc-cache; then
        fc-cache -fv >/dev/null 2>&1
        print_success "Font cache refreshed"
    fi

    # Check if Nerd Fonts are installed
    if fc-list | grep -qi "JetBrains"; then
        print_success "JetBrains Mono Nerd Font detected"
    else
        print_warning "JetBrains Mono Nerd Font not found - install with: yay -S ttf-jetbrains-mono-nerd"
    fi
}

# Function to configure system services
configure_services() {
    print_step "Configuring system services..."

    # Enable NetworkManager if not already enabled
    if systemctl is-enabled NetworkManager >/dev/null 2>&1; then
        print_info "NetworkManager already enabled"
    else
        sudo systemctl enable NetworkManager
        print_success "NetworkManager enabled"
    fi

    # Enable Bluetooth if available
    if systemctl list-unit-files | grep -q bluetooth.service; then
        if systemctl is-enabled bluetooth >/dev/null 2>&1; then
            print_info "Bluetooth already enabled"
        else
            sudo systemctl enable bluetooth
            print_success "Bluetooth enabled"
        fi
    fi

    # Start essential services
    sudo systemctl start NetworkManager 2>/dev/null || true
    sudo systemctl start bluetooth 2>/dev/null || true
}

# Function to set default applications
set_default_applications() {
    print_step "Setting default applications..."

    # Set default terminal
    if command_exists alacritty; then
        export TERMINAL="alacritty"
        print_success "Default terminal set to Alacritty"
    fi

    # Set default browser
    if command_exists firefox; then
        xdg-settings set default-web-browser firefox.desktop 2>/dev/null || true
        print_success "Default browser set to Firefox"
    fi

    # Set default file manager
    if command_exists thunar; then
        xdg-mime default thunar.desktop inode/directory 2>/dev/null || true
        print_success "Default file manager set to Thunar"
    fi
}

# Function to create desktop entry for qtile
create_desktop_entry() {
    print_step "Creating Qtile desktop entry..."

    local desktop_entry="/usr/share/xsessions/qtile.desktop"

    if [[ ! -f "$desktop_entry" ]] && command_exists qtile; then
        sudo tee "$desktop_entry" > /dev/null <<EOF
[Desktop Entry]
Name=Qtile
Comment=Qtile Desktop Environment
Exec=qtile start
Type=Application
Keywords=wm;tiling
EOF
        print_success "Qtile desktop entry created"
    else
        print_info "Qtile desktop entry already exists or qtile not installed"
    fi
}

# Function to run post-installation tasks
post_installation_tasks() {
    print_step "Running post-installation tasks..."

    # Update desktop database
    if command_exists update-desktop-database; then
        update-desktop-database ~/.local/share/applications/ 2>/dev/null || true
        print_success "Desktop database updated"
    fi

    # Update MIME database
    if command_exists update-mime-database; then
        update-mime-database ~/.local/share/mime/ 2>/dev/null || true
        print_success "MIME database updated"
    fi

    # Set up user directories
    if command_exists xdg-user-dirs-update; then
        xdg-user-dirs-update
        print_success "User directories updated"
    fi
}

# Function to display completion message
show_completion_message() {
    print_section "Installation Complete!"

    echo -e "${GREEN}${ROCKET} Your Qtile Desktop Environment is ready! ${ROCKET}${NC}\n"

    echo -e "${CYAN}📋 What was installed:${NC}"
    echo -e "${ARROW} Qtile window manager with Catppuccin Mocha theme"
    echo -e "${ARROW} Picom compositor with visual effects"
    echo -e "${ARROW} Rofi application launcher"
    echo -e "${ARROW} Complete system tray integration"
    echo -e "${ARROW} Development tools and applications"

    echo -e "\n${YELLOW}🔑 Key Shortcuts to Remember:${NC}"
    echo -e "${ARROW} Super + D: Application launcher"
    echo -e "${ARROW} Super + Return: Terminal"
    echo -e "${ARROW} Super + E: File manager"
    echo -e "${ARROW} Super + Q: Close window"
    echo -e "${ARROW} Super + 1-9: Switch workspaces"
    echo -e "${ARROW} Super + grave (~): Dropdown terminal"

    echo -e "\n${PURPLE}🎯 Next Steps:${NC}"
    echo -e "${ARROW} 1. Log out of your current session"
    echo -e "${ARROW} 2. Select 'Qtile' from your display manager"
    echo -e "${ARROW} 3. Log in and enjoy your new desktop!"
    echo -e "${ARROW} 4. Add a wallpaper to ~/Pictures/wallpaper.jpg"

    echo -e "\n${BLUE}📁 Configuration Files:${NC}"
    echo -e "${ARROW} ~/.config/qtile/config.py (main configuration)"
    echo -e "${ARROW} ~/.config/picom/picom.conf (visual effects)"
    echo -e "${ARROW} ~/.config/rofi/config.rasi (launcher theme)"

    echo -e "\n${GREEN}🎉 Enjoy your new Qtile desktop environment! 🎉${NC}\n"
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

    # Check if we're on Arch Linux
    if ! command_exists pacman; then
        print_error "This script is designed for Arch Linux and Arch-based distributions"
        exit 1
    fi

    # Change to script directory
    cd "$SCRIPT_DIR"

    # Parse command line arguments
    INSTALL_DEPS=true
    INSTALL_APPS=true
    CONFIGURE_ONLY=false

    case "${1:-}" in
        "deps-only")
            INSTALL_APPS=false
            print_info "Installing dependencies only"
            ;;
        "apps-only")
            INSTALL_DEPS=false
            print_info "Installing applications only"
            ;;
        "config-only")
            INSTALL_DEPS=false
            INSTALL_APPS=false
            CONFIGURE_ONLY=true
            print_info "Configuring system only"
            ;;
        "full"|""|*)
            print_info "Running full installation"
            ;;
    esac

    # Check for sudo access
    print_info "This script requires sudo access for system configuration"
    sudo -v

    # Install dependencies
    if [[ "$INSTALL_DEPS" == true ]]; then
        print_section "Installing System Dependencies"
        if [[ -f "install_dependencies.sh" ]]; then
            chmod +x install_dependencies.sh
            ./install_dependencies.sh
            print_success "Dependencies installation completed"
        else
            print_error "install_dependencies.sh not found!"
            exit 1
        fi
    fi

    # Install applications
    if [[ "$INSTALL_APPS" == true ]]; then
        print_section "Installing Additional Applications"
        echo -e "${YELLOW}Do you want to install additional applications? (Discord, Spotify, etc.)${NC}"
        read -p "Install applications? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [[ -f "install_apps.sh" ]]; then
                chmod +x install_apps.sh
                ./install_apps.sh
                print_success "Applications installation completed"
            else
                print_warning "install_apps.sh not found, skipping applications"
            fi
        else
            print_info "Skipping applications installation"
        fi
    fi

    # Configuration steps
    print_section "Configuring Qtile Desktop Environment"

    backup_configs
    copy_configurations
    setup_wallpaper
    setup_fonts
    configure_services
    set_default_applications
    create_desktop_entry
    post_installation_tasks

    # Final steps
    print_section "Finalizing Installation"

    # Test qtile configuration
    if command_exists qtile; then
        print_step "Testing Qtile configuration..."
        if qtile check; then
            print_success "Qtile configuration is valid"
        else
            print_warning "Qtile configuration has warnings, but should still work"
        fi
    fi

    show_completion_message
}

# Handle script interruption
trap 'echo -e "\n${RED}Installation interrupted!${NC}"; exit 1' INT

# Show usage if help is requested
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "  full (default)  - Install dependencies, apps, and configure"
    echo "  deps-only      - Install only system dependencies"
    echo "  apps-only      - Install only additional applications"
    echo "  config-only    - Only copy configurations and setup"
    echo "  --help, -h     - Show this help message"
    echo
    echo "Examples:"
    echo "  $0              # Full installation"
    echo "  $0 full         # Full installation"
    echo "  $0 deps-only    # Only install dependencies"
    echo "  $0 config-only  # Only setup configurations"
    exit 0
fi

# Run main function
main "$@"

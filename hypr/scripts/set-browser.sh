#!/usr/bin/env bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to print colored messages
print_message() {
    echo -e "${2}${1}${NC}"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_message "Please do not run this script as root!" "$RED"
    exit 1
fi

# Check if Brave is installed
if ! command -v brave &> /dev/null; then
    print_message "Brave browser is not installed. Please install it first." "$RED"
    exit 1
fi

print_message "Setting Brave as default browser..." "$BLUE"

# Set default browser using xdg-settings
xdg-settings set default-web-browser brave-browser.desktop

# Set default browser using mimeapps.list
mkdir -p ~/.config/mimeapps.list.d/
cat > ~/.config/mimeapps.list << EOF
[Default Applications]
x-scheme-handler/http=brave-browser.desktop
x-scheme-handler/https=brave-browser.desktop
x-scheme-handler/ftp=brave-browser.desktop
x-scheme-handler/chrome=brave-browser.desktop
text/html=brave-browser.desktop
application/x-extension-htm=brave-browser.desktop
application/x-extension-html=brave-browser.desktop
application/x-extension-shtml=brave-browser.desktop
application/xhtml+xml=brave-browser.desktop
application/x-extension-xhtml=brave-browser.desktop
application/x-extension-xht=brave-browser.desktop

[Added Associations]
x-scheme-handler/http=brave-browser.desktop;
x-scheme-handler/https=brave-browser.desktop;
x-scheme-handler/ftp=brave-browser.desktop;
x-scheme-handler/chrome=brave-browser.desktop;
text/html=brave-browser.desktop;
application/x-extension-htm=brave-browser.desktop;
application/x-extension-html=brave-browser.desktop;
application/x-extension-shtml=brave-browser.desktop;
application/xhtml+xml=brave-browser.desktop;
application/x-extension-xhtml=brave-browser.desktop;
application/x-extension-xht=brave-browser.desktop;
EOF

# Set environment variables
if ! grep -q "export BROWSER=brave" ~/.profile; then
    echo "export BROWSER=brave" >> ~/.profile
fi

if ! grep -q "export DEFAULT_BROWSER=brave" ~/.profile; then
    echo "export DEFAULT_BROWSER=brave" >> ~/.profile
fi

# Update system defaults
update-alternatives --set x-www-browser /usr/bin/brave 2>/dev/null || true
update-alternatives --set gnome-www-browser /usr/bin/brave 2>/dev/null || true

print_message "Brave has been set as your default browser!" "$GREEN"
print_message "Please log out and back in for all changes to take effect." "$YELLOW"

# Gabriel's Dotfiles - Qtile Desktop Environment

A comprehensive dotfiles repository featuring a fully-configured Qtile desktop environment with the beautiful Catppuccin Mocha theme. This setup transforms Qtile into a complete desktop environment while preserving all tiling window manager capabilities.

## 🌟 Features

### **🎨 Qtile Desktop Environment**
- **Beautiful Catppuccin Mocha Theme** - Consistent theming across all components
- **Tiling Window Manager** - Multiple layouts with smart window management
- **Compositor Effects** - Transparency, shadows, blur, and rounded corners with Picom
- **Application Launcher** - Rofi with custom Catppuccin theme
- **System Tray Integration** - Network, Bluetooth, audio, and power management
- **Scratchpad Support** - Dropdown terminal, calculator, and file manager
- **Multi-Monitor Ready** - Automatic display configuration
- **Media Key Support** - Volume, brightness, and playback controls

### **🚀 Desktop Environment Components**
- **Status Bar** - Powerline-style bar with system monitoring
- **Notifications** - Desktop notifications with Dunst
- **File Manager** - Thunar with archive support
- **Screenshot Tool** - Flameshot integration
- **Clipboard Manager** - Parcellite for clipboard history
- **Power Management** - Screen locking and power controls
- **Auto-mounting** - USB device management with Udiskie
- **Blue Light Filter** - Redshift for eye comfort

### **⚙️ Development Setup**
- **Neovim Configuration** - Modern IDE-like setup
- **Tmux Configuration** - Terminal multiplexer setup
- **Terminal** - Alacritty with transparency support
- **Shell Enhancements** - Zsh with Oh My Zsh

## 📁 Repository Structure

```
dotfiles/
├── qtile/                          # Qtile desktop environment
│   ├── config.py                   # Main qtile configuration
│   ├── autostart.sh               # Desktop environment startup
│   └── README.md                  # Qtile-specific documentation
├── picom/                         # Compositor configuration
│   └── picom.conf                 # Visual effects and transparency
├── rofi/                          # Application launcher
│   └── config.rasi                # Catppuccin-themed launcher
├── nvim/                          # Neovim configuration
├── my_scripts/                    # Installation and setup scripts
│   ├── install_dependencies.sh    # Core system dependencies
│   ├── install_apps.sh           # Additional applications
│   ├── setup.sh                  # Main setup coordinator
│   └── yay-git/                  # AUR helper build files
├── .tmux.conf                     # Tmux configuration
├── autostart.sh                   # System-wide autostart
├── install-dependencies.sh        # Comprehensive installer
└── README.md                      # This file
```

## 🚀 Quick Installation

### **Method 1: Full Automated Installation**

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Run the comprehensive installer (recommended)
chmod +x install-dependencies.sh
./install-dependencies.sh
```

### **Method 2: Manual Installation using Scripts**

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles/my_scripts

# Run the setup script
chmod +x setup.sh
./setup.sh
```

### **Method 3: Step-by-Step Installation**

```bash
# 1. Install core dependencies
cd my_scripts
chmod +x install_dependencies.sh
./install_dependencies.sh

# 2. Install additional applications
chmod +x install_apps.sh
./install_apps.sh

# 3. Copy configurations
cp -r ../qtile ~/.config/
cp -r ../picom ~/.config/
cp -r ../rofi ~/.config/
cp -r ../nvim ~/.config/
cp ../.tmux.conf ~/
```

## 📋 Dependencies

### **Core Requirements**
- **Qtile** - Window manager
- **Python** - Qtile dependencies (psutil, iwlib, dbus-next)
- **Picom** - Compositor for visual effects
- **Rofi** - Application launcher
- **Alacritty** - Terminal emulator

### **Desktop Environment**
- **Dunst** - Notification daemon
- **Thunar** - File manager
- **NetworkManager** - Network management
- **Blueman** - Bluetooth management
- **PulseAudio** - Audio system
- **Flameshot** - Screenshot tool

### **System Utilities**
- **Brightnessctl** - Brightness control
- **Playerctl** - Media control
- **Udiskie** - Auto-mounting
- **Redshift** - Blue light filter
- **XFCE4 Power Manager** - Power management

### **Fonts and Themes**
- **JetBrains Mono Nerd Font** - Main font
- **Papirus Icon Theme** - Icons
- **Catppuccin GTK Theme** - System theme
- **Bibata Cursor Theme** - Mouse cursors

## ⌨️ Key Bindings

### **Window Management**
| Shortcut | Action |
|----------|---------|
| `Super + h/j/k/l` | Move focus left/down/up/right |
| `Super + Shift + h/j/k/l` | Move window |
| `Super + Ctrl + h/j/k/l` | Resize window |
| `Super + q` | Close window |
| `Super + f` | Toggle fullscreen |
| `Super + Tab` | Next layout |

### **Applications**
| Shortcut | Action |
|----------|---------|
| `Super + Return` | Terminal |
| `Super + d` | Application launcher |
| `Super + e` | File manager |
| `Super + b` | Web browser |
| `Super + c` | Code editor |
| `Super + Shift + s` | Screenshot |

### **Workspaces**
| Shortcut | Action |
|----------|---------|
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Left/Right` | Previous/Next workspace |

### **System Controls**
| Shortcut | Action |
|----------|---------|
| `Volume Keys` | Audio control |
| `Brightness Keys` | Screen brightness |
| `Super + Ctrl + l` | Lock screen |
| `Super + grave` | Dropdown terminal |

## 🎨 Customization

### **Colors and Theme**
The configuration uses Catppuccin Mocha colors. Edit `qtile/config.py` to customize:

```python
colors = {
    'base': '#1e1e2e',     # Background
    'text': '#cdd6f4',     # Text
    'mauve': '#cba6f7',    # Accent
    # Add your custom colors here
}
```

### **Applications**
Edit workspace assignments in `qtile/config.py`:

```python
group_names = [
    ("1", {"label": "󰣇", "spawn": ["your-app"]}),
    ("2", {"label": "", "spawn": ["firefox"]}),
    # Customize your workspaces
]
```

### **Autostart Applications**
Edit `qtile/autostart.sh` to add startup applications:

```bash
# Add your applications
discord --start-minimized &
spotify &
```

## 🛠️ Troubleshooting

### **Common Issues**

**Qtile not starting:**
```bash
# Check qtile configuration
qtile check

# View qtile logs
journalctl --user -u qtile
```

**Picom effects not working:**
```bash
# Test picom manually
picom --config ~/.config/picom/picom.conf
```

**Fonts not displaying:**
```bash
# Install Nerd Fonts
sudo pacman -S ttf-jetbrains-mono-nerd

# Refresh font cache
fc-cache -fv
```

**System tray empty:**
```bash
# Check autostart applications
ps aux | grep nm-applet
ps aux | grep blueman-applet

# Restart autostart
~/.config/qtile/autostart.sh
```

## 📱 Workspace Layout

| Workspace | Icon | Purpose | Auto-assigned |
|-----------|------|---------|---------------|
| 1 | 󰣇 | General | Terminal |
| 2 |  | Web | Firefox |
| 3 |  | Code | VS Code |
| 4 |  | Files | Thunar |
| 5 |  | General | - |
| 6 |  | Chat | Discord |
| 7 |  | Media | Spotify |
| 8 |  | General | - |
| 9 |  | General | - |

## 🔧 System Requirements

### **Minimum Requirements**
- **Arch Linux** (or Arch-based distribution)
- **4GB RAM** (8GB recommended)
- **Graphics card** with OpenGL support
- **Network connection** for installation

### **Supported Distributions**
- **Arch Linux** ✅
- **Manjaro** ✅
- **EndeavourOS** ✅
- **ArcoLinux** ✅

### **Display Server**
- **X11** (fully supported)
- **Wayland** (experimental qtile support)

## 📚 Documentation

- **[Qtile Documentation](http://docs.qtile.org/)** - Official qtile docs
- **[Catppuccin Theme](https://github.com/catppuccin/catppuccin)** - Theme information
- **[Arch Wiki - Qtile](https://wiki.archlinux.org/title/Qtile)** - Installation guide
- **[Picom Documentation](https://github.com/yshui/picom)** - Compositor setup

## 🤝 Contributing

Contributions are welcome! Here are ways to contribute:

1. **Report bugs** in the issues section
2. **Suggest features** or improvements
3. **Submit pull requests** with fixes or enhancements
4. **Share screenshots** of your customizations
5. **Improve documentation**

### **Development Setup**
```bash
# Fork the repository
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Create a branch for your changes
git checkout -b feature/your-feature-name

# Make your changes and test them
# Submit a pull request
```

## 📄 License

This dotfiles configuration is released under the MIT License. See [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- **[Qtile Community](https://github.com/qtile/qtile)** - Amazing window manager
- **[Catppuccin Team](https://github.com/catppuccin)** - Beautiful color palette
- **[Arch Linux](https://archlinux.org/)** - The distribution that makes this possible
- **Open Source Community** - For all the amazing tools

## 📊 Statistics

- **Configuration Files**: 50+
- **Key Bindings**: 40+
- **Supported Applications**: 30+
- **Workspace Layouts**: 8
- **Color Variants**: Catppuccin Mocha

---

**Enjoy your new Qtile desktop environment!** 🎉

For questions or support, please open an issue or check the documentation links above.

*Last updated: $(date +'%Y-%m-%d')*
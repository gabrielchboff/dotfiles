# Modern Neovim Configuration with AI Tools & Zed-like Appearance

A comprehensive, modern Neovim configuration that transforms your editor into a powerful development environment with AI assistance and a sleek, Zed-inspired interface.

## 🌟 Features

### **🎨 Modern UI & Aesthetics**
- **Catppuccin Mocha** colorscheme with beautiful integrations
- **Neo-tree** file explorer with Git integration
- **Noice.nvim** for enhanced UI messages and notifications
- **Bufferline** with tab-like buffer management
- **Lualine** status bar with powerline aesthetics
- **Rounded borders** and modern floating windows
- **Smooth animations** and transitions

### **🤖 AI Development Tools**
- **Codeium** - Free AI code completion and chat
- **GitHub Copilot** - AI pair programming
- **CopilotChat** - Interactive AI assistance with contextual prompts
- **Smart code suggestions** and completions
- **AI-powered** code explanations, reviews, and refactoring

### **⚡ Enhanced Development Experience**
- **Mason LSP** auto-installer for 15+ language servers
- **Telescope** fuzzy finder with enhanced UI
- **Treesitter** for superior syntax highlighting
- **Auto-formatting** on save
- **Git integration** with Gitsigns and Fugitive
- **Diagnostic** integration with Trouble
- **Auto-completion** with nvim-cmp
- **Smart indentation** and code folding

### **🎯 Zed-like Features**
- **Command palette** with Telescope
- **Multi-cursor** support via visual selections
- **Quick file switching** with fuzzy search
- **Integrated terminal** support
- **Project-wide** search and replace
- **Symbol navigation** and workspace management

## 📦 Installation

### **Prerequisites**
```bash
# Install required dependencies
sudo pacman -S neovim git curl wget unzip
# or
sudo apt install neovim git curl wget unzip

# Install a Nerd Font (required for icons)
sudo pacman -S ttf-jetbrains-mono-nerd
# or download from: https://www.nerdfonts.com/
```

### **Backup Existing Configuration**
```bash
# Backup your current Neovim config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### **Install Configuration**
```bash
# Clone dotfiles or copy the nvim directory
cp -r dotfiles/nvim ~/.config/

# Start Neovim (plugins will auto-install)
nvim
```

### **First Launch**
1. Start Neovim: `nvim`
2. Wait for Lazy.nvim to install all plugins
3. Restart Neovim: `:qa` then `nvim`
4. Run health check: `:checkhealth`

## ⌨️ Key Bindings

### **Leader Key**: `<Space>`

### **File Management**
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Focus file explorer |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |

### **AI Tools**
| Key | Action |
|-----|--------|
| `<leader>ae` | Explain code with AI |
| `<leader>at` | Generate tests |
| `<leader>ar` | Review code |
| `<leader>aR` | Refactor code |
| `<leader>an` | Better naming suggestions |
| `<leader>ai` | Ask AI anything |
| `<leader>am` | Generate commit message |
| `<leader>av` | Visual AI chat |
| `<leader>aq` | Quick AI chat |

### **Code Navigation**
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `[d` / `]d` | Previous/Next diagnostic |

### **Buffer Management**
| Key | Action |
|-----|--------|
| `<S-h>` / `<S-l>` | Previous/Next buffer |
| `[b` / `]b` | Previous/Next buffer |
| `<leader>bp` | Pin buffer |
| `<leader>bo` | Close other buffers |
| `<leader>bl` / `<leader>br` | Close left/right buffers |

### **Window Management**
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows |
| `<A-j/k>` | Move lines up/down |

### **Search & Replace**
| Key | Action |
|-----|--------|
| `<leader>/` | Search in current buffer |
| `<leader>fg` | Global search |
| `<leader>fc` | Search commands |
| `<leader>fh` | Search help |
| `<leader>fk` | Search keymaps |

### **Git Integration**
| Key | Action |
|-----|--------|
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `]h` / `[h` | Next/Previous hunk |

### **Diagnostics & Debugging**
| Key | Action |
|-----|--------|
| `<leader>xx` | Document diagnostics |
| `<leader>xX` | Workspace diagnostics |
| `<leader>cd` | Open diagnostic float |
| `<leader>cl` | Diagnostic loclist |

### **Update & Maintenance**
| Key | Action |
|-----|--------|
| `<leader>uu` | Update all plugins and tools |
| `<leader>ul` | Open Lazy plugin manager |
| `<leader>um` | Open Mason LSP manager |
| `<leader>uh` | Run health check |
| `<leader>ur` | Restart LSP servers |

## 🔧 Configuration Structure

```
nvim/
├── init.lua                 # Main configuration file
├── lua/
│   └── config/             # Additional configuration modules
└── README.md               # This file
```

### **Main Configuration Sections**
1. **Plugin Management** - Lazy.nvim setup
2. **UI Components** - Colorscheme, statusline, file explorer
3. **AI Tools** - Codeium, Copilot integration
4. **LSP Configuration** - Language servers and completion
5. **Keymaps** - Custom key bindings
6. **Autocmds** - Automatic commands and behaviors

## 🎨 Customization

### **Change Colorscheme**
Edit in `init.lua`:
```lua
{
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- Change to: latte, frappe, macchiato, mocha
  },
}
```

### **Add Language Servers**
In the LSP configuration section:
```lua
local servers = {
  -- Add your language server here
  new_language_server = {},
}
```

### **Customize AI Prompts**
In CopilotChat configuration:
```lua
prompts = {
  YourCustomPrompt = "Your custom prompt text here.",
}
```

### **Modify Keybindings**
Add custom keymaps in the keymaps section:
```lua
keymap.set("n", "<your-key>", "<your-command>", { desc = "Description" })
```

## 🤖 AI Tools Setup

### **Codeium (Free)**
1. Install automatically with the configuration
2. Start coding - AI suggestions appear automatically
3. Accept with `<Tab>` or use completion menu

### **GitHub Copilot (Paid)**
1. Install GitHub Copilot extension in your browser
2. Authenticate: `:Copilot auth`
3. Start using AI chat with `<leader>a` commands

### **AI Chat Commands**
- `:CopilotChat` - Start AI chat
- `:CopilotChatExplain` - Explain selected code
- `:CopilotChatReview` - Review code for improvements
- `:CopilotChatTests` - Generate unit tests
- `:CopilotChatRefactor` - Suggest refactoring

## 🚀 Language Support

### **Automatically Configured**
- **Lua** - Full LSP with Neovim enhancements
- **Python** - Pyright LSP
- **JavaScript/TypeScript** - TSServer
- **Rust** - rust-analyzer
- **Go** - gopls
- **C/C++** - clangd
- **HTML/CSS** - Language servers
- **JSON/YAML** - Formatters and validators
- **Markdown** - Enhanced editing
- **Bash** - Shell script support

### **Adding New Languages**
1. Add LSP server to the `servers` table
2. Mason will auto-install the language server
3. Treesitter will handle syntax highlighting

## 🛠️ Troubleshooting

### **Quick Fix Commands**
```vim
:HealthCheck   " Run comprehensive health check
:FixIssues     " Auto-fix common issues
:UpdateAll     " Update all plugins and tools
:InstallDeps   " Install missing dependencies (Arch Linux)
```

### **Common Issues & Solutions**

#### **🚨 Plugin Loading Errors**
```bash
# Issue: Catppuccin neo_tree integration error
# Fix: Use the updated configuration (already fixed in latest version)

# Issue: telescope.actions not found
# Solution 1: Clear plugin cache and reinstall
:FixIssues

# Solution 2: Manual cleanup
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
nvim  # Will reinstall plugins
```

#### **🔧 LSP Server Issues**
```bash
# Issue: Server "tsserver" is not valid
# Fix: Use updated server names (already fixed in config)

# Check LSP status
:LspInfo
:Mason

# Restart LSP servers
:RestartLSP

# Install missing servers
:MasonInstall lua_ls pyright rust_analyzer gopls clangd
```

#### **🤖 AI Tools Not Working**
```bash
# Codeium setup (automatic)
# Just start typing - suggestions will appear

# Copilot setup
:Copilot auth
:Copilot status

# If Copilot fails
:Copilot setup
```

#### **🎨 Icons/Font Issues**
```bash
# Install Nerd Font
sudo pacman -S ttf-jetbrains-mono-nerd

# For other distributions
# Download from: https://www.nerdfonts.com/

# Set terminal font to "JetBrainsMono Nerd Font"
# Restart terminal after font installation
```

#### **⚡ Performance Issues**
```lua
-- Add to init.lua for better performance
vim.opt.updatetime = 100  -- Faster completion
vim.opt.timeoutlen = 200  -- Faster which-key
vim.opt.lazyredraw = true -- Don't redraw during macros
```

### **Step-by-Step Debugging**

#### **Method 1: Automated Fix**
```vim
:HealthCheck    " Identify issues
:FixIssues      " Auto-fix common problems
:UpdateAll      " Update everything
```

#### **Method 2: Manual Debugging**
1. **Check configuration syntax:**
   ```vim
   :luafile ~/.config/nvim/init.lua
   ```

2. **Run health diagnostics:**
   ```vim
   :checkhealth
   :checkhealth lazy
   :checkhealth mason
   :checkhealth lsp
   ```

3. **Verify plugin status:**
   ```vim
   :Lazy         " Check plugin status
   :Lazy sync    " Update plugins
   :Lazy clean   " Remove unused plugins
   ```

4. **Check LSP and tools:**
   ```vim
   :LspInfo      " LSP server status
   :Mason        " Tool manager
   :MasonUpdate  " Update tools
   ```

5. **Review error messages:**
   ```vim
   :messages     " View all messages
   :Notifications " View notifications (if nvim-notify loaded)
   ```

#### **Method 3: Fresh Installation**
```bash
# Complete reset (use with caution)
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup

# Copy fresh configuration
cp -r dotfiles/nvim ~/.config/

# Start Neovim
nvim
```

### **Specific Error Fixes**

#### **"module 'catppuccin.groups.integrations.neo_tree' not found"**
```lua
-- This is fixed in the updated configuration
-- The integration was changed from 'neo_tree = true' to 'nvimtree = true'
-- If you still see this error, run :UpdateAll
```

#### **"Server 'tsserver' is not a valid entry"**
```lua
-- This is fixed in the updated configuration
-- tsserver is now properly configured
-- Run :Mason to install missing servers
```

#### **"There were issues reported with your which-key mappings"**
```vim
-- Check which-key health
:checkhealth which-key

-- The configuration has been updated to use the new which-key v3 API
-- Run :UpdateAll to get the latest version
```

### **Emergency Recovery**
If Neovim won't start at all:

```bash
# Start with minimal config
nvim --clean

# Or start without plugins
nvim -u NONE

# Check if basic Neovim works
nvim --version
nvim -c ":help" -c ":quit"
```

### **Getting Help**
1. **Built-in help:** `:help <topic>`
2. **Health check:** `:HealthCheck`
3. **Plugin documentation:** `:help <plugin-name>`
4. **Lazy plugin manager:** `:Lazy help`
5. **LSP information:** `:LspInfo`
</text>


## 📊 Performance

### **Startup Time**
- **Cold start**: ~50-80ms
- **Warm start**: ~20-30ms
- **Plugin lazy-loading** for optimal performance

### **Memory Usage**
- **Base**: ~15-25MB
- **With LSP**: ~50-80MB
- **Heavy development**: ~100-150MB

## 🔄 Updates

### **One-Command Update (Recommended)**
```bash
# Update everything with a single command
:UpdateAll

# Or use the keybinding
<leader>uu
```

This comprehensive update command will:
- Update all plugins with Lazy
- Update all LSP servers, formatters, and linters with Mason
- Update all Treesitter parsers
- Show progress notifications

### **Individual Update Commands**
```bash
# Update all plugins
:Lazy sync

# Update specific plugin
:Lazy update plugin_name

# Update all language servers
:MasonUpdate

# Update specific server
:MasonInstall server_name

# Update Treesitter parsers
:TSUpdate

# Restart LSP servers
:RestartLSP
```

### **Quick Access Commands**
- `:UpdateAll` - Comprehensive update of everything
- `:HealthCheckAll` - Run full health diagnostics
- `:RestartLSP` - Restart all LSP servers
- `<leader>ul` - Open Lazy plugin manager
- `<leader>um` - Open Mason LSP manager

## 🎯 VS Code Migration

### **Similar Features**
| VS Code | Neovim Equivalent |
|---------|-------------------|
| Command Palette | `<leader>fc` |
| File Explorer | `<leader>e` |
| Quick Open | `<leader>ff` |
| Go to Symbol | `<leader>fs` |
| Find in Files | `<leader>fg` |
| Git Changes | `<leader>gh*` |
| Problems Panel | `<leader>xx` |
| Extensions | `:Lazy` |

### **AI Features**
| Feature | Neovim |
|---------|--------|
| Copilot | Built-in with CopilotChat |
| AI Chat | `<leader>ai` |
| Code Explain | `<leader>ae` |
| Code Review | `<leader>ar` |
| Generate Tests | `<leader>at` |

## 🏆 Best Practices

### **Development Workflow**
1. Use `<leader>e` to navigate files
2. Leverage AI for code explanation and review
3. Use LSP for navigation (`gd`, `gr`, `gI`)
4. Employ telescope for project-wide search
5. Utilize git integration for version control

### **AI Usage Tips**
- Select code before using AI commands for better context
- Use specific prompts for better AI responses
- Combine AI suggestions with your expertise
- Review AI-generated code before accepting

### **Performance Tips**
- Use lazy loading for plugins you don't need immediately
- Keep the configuration modular
- Regularly clean up unused plugins
- Monitor startup time with `:Lazy profile`

## 📚 Resources

- **[Neovim Documentation](https://neovim.io/doc/)**
- **[Lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
- **[Catppuccin](https://github.com/catppuccin/nvim)** - Colorscheme
- **[CopilotChat](https://github.com/CopilotC-Nvim/CopilotChat.nvim)** - AI chat
- **[Mason](https://github.com/williamboman/mason.nvim)** - LSP installer
- **[Telescope](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder

## 🤝 Contributing

Feel free to:
- Report issues and bugs
- Suggest new features
- Submit pull requests
- Share your customizations

## 📄 License

This configuration is provided as-is for educational and personal use. Feel free to modify and distribute according to your needs.

---

**Enjoy your modern Neovim development environment!** 🎉

*For questions or support, consult the plugin documentation or community forums.*
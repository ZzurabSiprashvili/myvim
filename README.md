# 🚀 Neovim Configuration

A modern, feature-rich Neovim configuration optimized for productivity and developer experience. This setup provides comprehensive language support, intelligent code completion, advanced navigation, and seamless terminal integration.

## ✨ Features

### 🎯 Core Capabilities

- **25+ Plugins** - Carefully curated plugin ecosystem
- **15+ Languages** - Full LSP, formatting, and linting support
- **Modern Completion** - Blink.cmp with intelligent suggestions
- **Advanced Navigation** - Telescope, Flash, and Yazi integration
- **Git Integration** - LazyGit and Gitsigns for seamless version control
- **Terminal Management** - Multi-terminal support with language-specific terminals

### 🛠️ Language Support

- **Python** - Ruff (linting/formatting), Pyright LSP
- **JavaScript/TypeScript** - ESLint, Prettier, TypeScript LSP
- **Go** - gofmt, golint, gopls
- **Rust** - rustfmt, clippy, rust-analyzer
- **C/C++** - clang-format, clangd
- **Lua** - Stylua, Lua LSP
- **And more** - Full support for web development, data science, and more

### 🎨 UI & Experience

- **Noctis High Contrast** - Professional color scheme
- **Lualine** - Informative status line
- **Bufferline** - Tab management
- **Alpha Dashboard** - Beautiful startup screen
- **Indentation Guides** - Visual code structure
- **Smooth Cursor** - Enhanced cursor animations

## 📦 Installation

### Prerequisites

- **Neovim 0.11.3+** - Latest stable version
- **Git** - Version control
- **Node.js 18+** - For LSP servers and tools
- **Python 3.8+** - For Python development
- **Ripgrep** - For fast text search
- **fd** - For fast file finding

### Quick Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim
   cd ~/.config/nvim
   ```

2. **Install plugins**

   ```bash
   nvim --headless -c 'Lazy sync' -c 'qa'
   ```

3. **Install language servers and tools**

   ```bash
   nvim --headless -c 'MasonInstallAll' -c 'qa'
   ```

4. **Start Neovim**
   ```bash
   nvim
   ```

### Bootstrap Script

For a completely automated setup, use the bootstrap script:

```bash
# Make script executable
chmod +x bootstrap.sh

# Run bootstrap
./bootstrap.sh
```

## ⚙️ Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration entry point
├── lua/
│   ├── options.lua          # Core Neovim options
│   ├── mappings.lua         # Key mappings
│   ├── commands.lua         # Custom commands
│   ├── lazy_config.lua      # Lazy plugin manager config
│   └── plugins/
│       ├── init.lua         # Plugin specifications
│       ├── configs/         # Plugin configurations
│       │   ├── lspconfig.lua
│       │   ├── conform.lua
│       │   ├── blink.lua
│       │   └── ...
│       └── keys/            # Plugin keybindings
│           ├── telescope.lua
│           ├── flash.lua
│           └── ...
├── lazy-lock.json           # Plugin lockfile
└── README.md               # This file
```

## ⌨️ Key Mappings

### Leader Key

- **Space** - Primary leader key

### Core Navigation

- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fb` - Find buffers (Telescope)
- `<leader>fh` - Help tags (Telescope)
- `<leader>e` - Open file manager (Yazi)
- `<leader>E` - Open file manager (current directory)

### LSP & Code Actions

- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>F` - Format current buffer
- `<leader>tf` - Toggle format on save

### Git Integration

- `<leader>gg` - Open LazyGit
- `]h` / `[h` - Next/previous git hunk
- `<leader>gb` - Blame line
- `<leader>gB` - Blame buffer
- `<leader>gd` - Diff this

### Terminal Management

- `<leader>H` - Toggle horizontal terminal
- `<leader>L` - Toggle vertical terminal
- `<leader>hP` - Python terminal (horizontal)
- `<leader>lP` - Python terminal (vertical)
- `<leader>hN` - Node.js terminal (horizontal)
- `<leader>lN` - Node.js terminal (vertical)
- `<leader>hC` - Claude terminal (floating)

### Window Management

- `<C-h/j/k/l>` - Navigate windows
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>se` - Equalize splits

### Diagnostics

- `<leader>d` - Open diagnostics
- `[d` / `]d` - Previous/next diagnostic
- `<leader>cs` - Toggle outline/symbols

### Search & Navigation

- `s` - Flash search (2-character)
- `S` - Flash search (treesitter)
- `<leader>.` - Open scratchpad

## 🔧 Customization

### Adding New Plugins

1. Edit `lua/plugins/init.lua`
2. Add your plugin in the appropriate category
3. Create configuration in `lua/plugins/configs/`
4. Add keybindings in `lua/plugins/keys/`

Example:

```lua
-- In lua/plugins/init.lua
{
  "your/plugin",
  config = function()
    require "plugins.configs.your_plugin"
  end,
},

-- In lua/plugins/configs/your_plugin.lua
-- Your plugin configuration
```

### Modifying Keybindings

Edit `lua/mappings.lua` or create plugin-specific key files in `lua/plugins/keys/`.

### Changing Colors

The configuration uses Noctis High Contrast theme. To change:

1. Edit the colorscheme in `lua/plugins/init.lua`
2. Update highlight groups in individual plugin configs

## 🐛 Troubleshooting

### Common Issues

**1. Plugin not loading**

```bash
# Clear plugin cache
rm -rf ~/.local/share/nvim/lazy
rm ~/.local/share/nvim/lazy-lock.json
# Reinstall
nvim --headless -c 'Lazy sync' -c 'qa'
```

**2. LSP not working**

```bash
# Check Mason
:Mason
# Install missing servers
:MasonInstall <server-name>
# Restart LSP
:LspRestart
```

**3. Formatting not working**

```bash
# Check Conform
:ConformInfo
# Install missing formatters via Mason
```

**4. Performance issues**

```bash
# Profile startup time
nvim --startuptime startup.log
# Check health
:checkhealth
```

### Health Check

Run Neovim's built-in health check:

```bash
nvim --headless -c 'checkhealth' -c 'qa'
```

### Debug Mode

Enable debug logging:

```bash
# In init.lua
vim.lsp.set_log_level("debug")
```

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason](https://github.com/williamboman/mason.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This configuration is licensed under the MIT License. See LICENSE file for details.

## 🙏 Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim) - Inspiration and best practices
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Foundation structure
- The amazing Neovim community and plugin authors

---

**Happy coding! 🎉**

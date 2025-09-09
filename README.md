# TrickerPan's Neovim Configuration

A modern Neovim configuration using `mini.nvim` as the plugin manager, providing a complete development environment.

## ✨ Features

- 🚀 Lightweight plugin management based on `mini.nvim`
- 🎨 Tokyo Night theme
- 📝 LSP support for multiple programming languages
- 🤖 GitHub Copilot integration
- 🌳 Treesitter syntax highlighting
- ⚡ Fast startup and responsive

## 📦 Plugin List

### Core Plugins

- **echasnovski/mini.nvim** - Plugin manager and various utilities
- **folke/tokyonight.nvim** - Modern theme
- **github/copilot.vim** - AI code completion
- **neovim/nvim-lspconfig** - LSP client configuration
- **nvim-treesitter/nvim-treesitter** - Syntax highlighting and parsing
- **nvimtools/none-ls.nvim** - Formatting and diagnostics

### Mini.nvim Modules

- **mini.basics** - Basic configuration and keymaps
- **mini.statusline** - Status line
- **mini.tabline** - Tab line
- **mini.starter** - Start screen
- **mini.icons** - Icon support
- **mini.extra** - Extra functionality

## 🛠️ Supported Languages

Supports the following programming languages through LSP and Treesitter:

- **Frontend**: JavaScript, TypeScript, HTML, CSS, TailwindCSS
- **Backend**: Python, Java, Lua
- **Markup**: Markdown, JSON, YAML, TOML, XML
- **Scripting**: Bash, PowerShell
- **Configuration**: Vim script

## 📋 Installation

### Prerequisites

- Neovim >= 0.9.0
- Git
- Node.js (for some LSP servers)
- Python 3 (for Python LSP)

### Installation Steps

1. **Clone the configuration**

   ```shell
   git clone https://github.com/TrickerPan/nvim.git ~/.config/nvim
   ```

2. **Start Neovim**

   ```shell
   nvim
   ```

   On first startup, `mini.nvim` and other dependencies will be automatically installed.

## ⚙️ Configuration

### Unix/Linux/macOS

Add the following to `.bashrc`, `.profile`, `.zshrc`, etc.:

```shell
alias vim="nvim"
alias vi="nvim"
```

### Windows

Add to `$ENV:LOCALAPPDATA\nvim\init.lua`:

```lua
local home_config_path = vim.fn.expand('~/.config/nvim')
vim.opt.runtimepath:prepend(home_config_path)
local home_init = home_config_path .. '/init.lua'
dofile(home_init)
```

## 📁 Directory Structure

```text
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config.lua          # Basic configuration
│   ├── deps/               # Plugin configurations
│   │   ├── appearance.lua  # Theme and appearance
│   │   ├── editing.lua     # Editing enhancements
│   │   ├── mini.lua        # Mini.nvim modules
│   │   └── workflow.lua    # Workflow tools
│   ├── helpers/
│   │   └── basic.lua       # Helper functions
│   └── lspconfig/          # LSP configurations
│       ├── java.lua
│       ├── lua.lua
│       ├── python.lua
│       ├── tailwindcss.lua
│       └── typescript.lua
└── snippets/
    └── global.json         # Global snippets
```

## 🎯 Keybindings

### Copilot

- `Tab` (insert mode): Accept Copilot suggestion

### Basic Operations

- Inherits all default keybindings from `mini.basics`
- Supports Alt + arrow keys for line movement

## 🔧 Customization

You can customize the configuration by modifying the following files:

- `lua/config.lua` - Basic Vim settings
- `lua/deps/` - Plugin-related configurations
- `lua/lspconfig/` - Language-specific LSP configurations

## 📄 License

This configuration is licensed under the MIT License.

# Neovim Config

> A lean, modular Neovim configuration built entirely around the [mini.nvim](https://github.com/echasnovski/mini.nvim) ecosystem.

No plugin managers, no bloat — just `mini.deps` bootstrapping everything from a single `init.lua`. Cross-platform support for macOS, Windows, and Linux with OS-aware keybindings.

## Features

- **Single ecosystem** — Nearly all plugins come from `mini.nvim`, ensuring a consistent API and minimal overhead
- **Modular layout** — Plugins are grouped by concern (`appearance`, `editing`, `workflow`) for easy navigation
- **LSP out of the box** — Preconfigured servers for Lua, Java, Python, TypeScript, and Tailwind CSS
- **Treesitter syntax** — Rich highlighting for 18+ languages
- **GitHub Copilot** — Integrated AI completions with sensible keybindings
- **Cross-platform** — macOS Command-key bindings alongside standard Ctrl alternatives

## Requirements

- [Neovim](https://neovim.io/) >= 0.10
- [Git](https://git-scm.com/) (for plugin bootstrapping)
- Language servers for LSP features (installed separately):

  | Language | Server |
  |---|---|
  | Lua | [`lua-language-server`](https://github.com/LuaLS/lua-language-server) |
  | Java | [`jdtls`](https://github.com/eclipse-jdtls/eclipse.jdt.ls) |
  | Python | [`pyright`](https://github.com/microsoft/pyright) |
  | TypeScript/JavaScript | [`typescript-language-server`](https://github.com/typescript-language-server/typescript-language-server) |
  | Tailwind CSS | [`tailwindcss-language-server`](https://github.com/tailwindlabs/tailwindcss-intellisense) |

## Installation

Back up your existing config if needed, then clone this repo into your Neovim config directory:

```bash
# Linux / macOS
git clone https://github.com/<your-username>/nvim-config ~/.config/nvim

# Windows
git clone https://github.com/<your-username>/nvim-config %LOCALAPPDATA%\nvim
```

On first launch, `mini.nvim` and all plugins are automatically bootstrapped. Treesitter parsers install in the background.

> [!NOTE]
> The first startup will be slower as all plugins and parsers are downloaded. Subsequent starts are fast.

## Structure

```
init.lua                  # Entry point — bootstraps mini.nvim and loads modules
lua/
  config.lua              # Core options (encoding, indentation, filetype rules)
  helpers/
    basic.lua             # OS detection, root_pattern, safe keymap_set
  deps/
    mini.lua              # All mini.nvim plugin setup
    appearance.lua        # Colorscheme (Tokyo Night)
    editing.lua           # none-ls for linting & formatting
    workflow.lua          # Treesitter, LSP, Copilot
  lspconfig/
    lua.lua               # lua_ls
    java.lua              # jdtls
    python.lua            # pyright
    typescript.lua        # ts_ls
    tailwindcss.lua       # tailwindcss
snippets/
  global.json             # Global snippets loaded by mini.snippets
```

## Plugins

### mini.nvim modules

| Module | Purpose |
|---|---|
| `mini.deps` | Plugin manager |
| `mini.basics` | Sensible defaults and common keymaps |
| `mini.starter` | Start screen |
| `mini.statusline` | Status bar |
| `mini.tabline` | Tab/buffer bar |
| `mini.icons` | Icon provider (nvim-web-devicons compatible) |
| `mini.notify` | Notification UI |
| `mini.files` | File explorer |
| `mini.pick` | Fuzzy finder |
| `mini.completion` | Autocompletion |
| `mini.snippets` | Snippet engine |
| `mini.ai` | Extended text objects |
| `mini.comment` | Code commenting |
| `mini.surround` | Surrounding pairs |
| `mini.pairs` | Auto pairs |
| `mini.move` | Move lines and selections |
| `mini.operators` | Extra operators |
| `mini.splitjoin` | Split/join code blocks |
| `mini.align` | Align text |
| `mini.bracketed` | Bracket navigation |
| `mini.jump` / `mini.jump2d` | Fast cursor movement |
| `mini.bufremove` | Buffer management |
| `mini.sessions` | Session management |
| `mini.visits` | File visit history |
| `mini.diff` | Inline diff visualization |
| `mini.git` | Git integration |
| `mini.clue` | Keybinding hints (which-key style) |
| `mini.animate` | Smooth animations |
| `mini.cursorword` | Highlight word under cursor |
| `mini.indentscope` | Visual indentation guides |
| `mini.trailspace` | Trailing whitespace highlighting |
| `mini.hipatterns` | Highlight `TODO`/`FIXME`/`HACK`/`NOTE` and hex colors |
| `mini.extra` | Extra pickers, text objects, highlighters |

### External plugins

| Plugin | Purpose |
|---|---|
| [`tokyonight.nvim`](https://github.com/folke/tokyonight.nvim) | Colorscheme (night variant) |
| [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | LSP client configuration |
| [`none-ls.nvim`](https://github.com/nvimtools/none-ls.nvim) | Linting & formatting via null-ls sources |
| [`copilot.vim`](https://github.com/github/copilot.vim) | GitHub Copilot completions |

## Key Bindings

> [!NOTE]
> macOS uses Command (`⌘`) keys where listed. On other platforms, `Ctrl` equivalents apply unless noted.

### Navigation

| Key | Action |
|---|---|
| `⌘E` / `Ctrl+E` | Toggle file explorer (opens at project root) |
| `<leader>pf` | Fuzzy find files |
| `<leader>pc` | Fuzzy find commands |
| `⌘H/J/K/L` | Focus window left/down/up/right |

### Editing

| Key | Action |
|---|---|
| `⌘S` | Save file |
| `gy` | Copy to system clipboard |
| `gp` | Paste from system clipboard |
| `gO` / `go` | Insert empty line above/below |
| `gV` | Visually select last changed/yanked text |
| `<leader>bd` | Delete buffer |
| `<leader>bw` | Wipeout buffer |

### Copilot

| Key | Action |
|---|---|
| `⌥Tab` (macOS) / `Tab` | Accept Copilot suggestion |

### Completion

| Key | Action |
|---|---|
| `⌘Space` / `Ctrl+Space` | Force two-step completion |
| `⌥Space` | Force fallback completion |

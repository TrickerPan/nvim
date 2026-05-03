# Neovim Config — Agent Instructions

See [README.md](README.md) for full project overview, requirements, and structure.

## Plugin Manager: `mini.deps`

**Not** lazy.nvim or packer. Every `deps/*.lua` file starts with:
```lua
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
```

- `now(fn)` — runs immediately on startup (UI: colorscheme, statusline, tabline)
- `later(fn)` — deferred until after startup (LSP, Treesitter, editing tools)
- `mini.nvim` itself is installed once in `init.lua`; all `mini.*` modules are available without a separate `add()` call

## Adding a Plugin

Add `add({source = '...', ...})` + `require(...)` inside the appropriate `later()` block in `lua/deps/*.lua`. Never add plugins in `init.lua`.

## LSP: Native Neovim 0.11+ API

**Do not** use `require('lspconfig').server.setup({})`. Every file in `lua/lsp/` follows this two-line pattern:
```lua
vim.lsp.config('server_name', {})
vim.lsp.enable('server_name')
```

To add a new language server:
1. Create `lua/lsp/<name>.lua` with the two lines above
2. Add `require('lsp.<name>')` inside the `later()` block in `lua/deps/workflow.lua`

## Helpers (`lua/helpers/basic.lua`)

```lua
local helpers = require('helpers.basic')
helpers.is_mac / helpers.is_win / helpers.is_linux  -- platform detection
helpers.root_pattern(...)   -- search upward for project root by glob
helpers.keymap_set(modes, lhs, rhs, opts)  -- safe wrapper, won't override existing non-default maps
```

## Cross-Platform Keymaps

macOS uses `<D-*>` (Cmd key), other platforms use `<C-*>`. Always branch on `helpers.is_mac`.

## Treesitter

Configured in `lua/deps/workflow.lua` inside a `now()` block. Add new parsers to `ensure_installed` there.

## openspec/

Change management via a spec-driven workflow. Write specs/proposals in Chinese; keep technical terms (API, LSP, etc.) and all code/paths in English. See `openspec/config.yaml` for context rules.

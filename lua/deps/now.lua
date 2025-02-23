local add, now = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  -- Encoding
  vim.g.encding = "utf-8"
  vim.o.fileencoding = "utf-8"

  -- Indent
  vim.o.tabstop = 4
  vim.o.softtabstop = 4
  vim.o.shiftwidth = 4
  vim.o.expandtab = true
  vim.o.autoindent = true

  -- Text edit
  vim.o.autoread = true
  vim.o.hidden = true

  -- Cursor around
  vim.o.scrolloff = 8
  vim.o.sidescrolloff = 8

  -- Theming
  vim.o.termguicolors = true

  -- Key mappings
  vim.keymap.set('n', '<D-s>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save', silent = true })
  vim.keymap.set({ 'i', 'x' }, '<D-s>', '<Esc><Cmd>silent! update | redraw<CR>',
    { desc = 'Save and go to Normal mode', silent = true })
end)
now(function()
  require('mini.basics').setup({
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'default',
    },
    mappings = {
      basic = true,
      option_toggle_prefix = [[\]],
      windows = true,
      move_with_alt = true,
    },
    autocommands = {
      basic = true,
      relnum_in_visual_mode = true,
    },
  })
end)
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.extra').setup() end)
now(function() require('mini.animate').setup() end)
now(function() require('mini.cursorword').setup() end)
now(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = require('mini.extra').gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme     = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
      hack      = hi_words({ 'HACK' }, 'MiniHipatternsHack'),
      todo      = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
      note      = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)
now(function() require('mini.icons').setup() end)
now(function() require('mini.indentscope').setup() end)
now(function() require('mini.starter').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)
now(function() require('mini.trailspace').setup() end)

now(function()
  add({
    source = 'folke/tokyonight.nvim',
  })
  vim.cmd('colorscheme tokyonight-night')
end)

now(function()
  add({
    source = 'neovim/nvim-lspconfig',
  })
  local lspconfig = require('lspconfig')
  lspconfig.pyright.setup {
    cmd = require('helpers.python').pyright_cmd,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'strict',
        },
        pythonPath = require('helpers.python').path,
      },
    },
  }
  lspconfig.jdtls.setup {}
  lspconfig.sourcekit.setup {}
  lspconfig.ts_ls.setup {}
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      },
    },
  }
end)

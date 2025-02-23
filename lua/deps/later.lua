local add, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  local ai = require('mini.ai')
  local gen_ai_spec = require('mini.extra').gen_ai_spec
  ai.setup({
    custom_textobjects = {
      B = gen_ai_spec.buffer(),
      D = gen_ai_spec.diagnostic(),
      I = gen_ai_spec.indent(),
      L = gen_ai_spec.line(),
      N = gen_ai_spec.number(),
    },
  })
end)
later(function() require('mini.align').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function()
  local clue = require('mini.clue')
  clue.setup({
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
  })
end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.completion').setup() end)
later(function() require('mini.diff').setup() end)
later(function()
  local files = require('mini.files')
  files.setup()
  vim.keymap.set('n', '<Leader>f', files.open, { desc = "Open MiniFiles", silent = true })
end)
later(function() require('mini.git').setup() end)
later(function() require('mini.jump').setup() end)
later(function() require('mini.jump2d').setup() end)
later(function() require('mini.move').setup() end)
later(function() require('mini.operators').setup() end)
later(function() require('mini.pairs').setup() end)
later(function() require('mini.pick').setup() end)
later(function() require('mini.sessions').setup() end)
later(function() require('mini.splitjoin').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.visits').setup() end)

later(function()
  local snippets = require('mini.snippets')
  local gen_loader = snippets.gen_loader
  snippets.setup({
    snippets = {
      gen_loader.from_file('~/.config/nvim/snippets/global.json'),
      gen_loader.from_lang(),
    }
  })
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  local treesitter = require('nvim-treesitter')
  treesitter.setup({
    ensure_installed = {
      'python',
      'java',
      'swift',
      'swift',

      'html',
      'css',
      'javascript',
      'typescript',

      'json',
      'yaml',
      'toml',
      'markdown',

      'lua',
      'vimdoc',
    },

    sync_install = false,
    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end)

later(function()
  add({
    source = 'github/copilot.vim',
  })
end)

local extra = require('mini.extra')

local module = {}

function module.setup_extra()
  extra.setup()
end

function module.setup_ai()
  local spec = extra.gen_ai_spec
  require('mini.ai').setup({
    custom_textobjects = {
      B = spec.buffer(),
      D = spec.diagnostic(),
      I = spec.indent(),
      L = spec.line(),
      N = spec.number(),
    },
  })
end

function module.setup_hipatterns()
  local hipatterns = require('mini.hipatterns')
  local high_words = extra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = high_words({ 'FIXME' }, 'MiniHipatternsFixme'),
      hack  = high_words({ 'HACK' }, 'MiniHipatternsHack'),
      todo  = high_words({ 'TODO' }, 'MiniHipatternsTodo'),
      note  = high_words({ 'NOTE' }, 'MiniHipatternsNote'),

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end

function module.setup_clue()
  local miniclue = require('mini.clue')
  miniclue.setup({
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









      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  })
end

return module


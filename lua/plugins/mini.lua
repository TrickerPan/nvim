return {
  "echasnovski/mini.nvim",
  version = "*",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- require("mini.ai").setup()
    -- require("mini.align").setup()
    require("mini.animate").setup()
    -- require("mini.base16").setup()
    require("mini.basics").setup()
    require("mini.bracketed").setup()
    require("mini.bufremove").setup()
    -- require("mini.colors").setup()
    require("mini.comment").setup()
    require('mini.completion').setup()
    require("mini.cursorword").setup()
    -- require('mini.extra').setup()
    require('mini.files').setup()
    require('mini.fuzzy').setup()
    -- require('mini.hipatterns').setup()
    -- require('mini.hues').setup()
    require('mini.indentscope').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.map').setup()
    -- require('mini.misc').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.pick').setup()
    require('mini.sessions').setup()
    require('mini.splitjoin').setup()
    require('mini.starter').setup()
    require("mini.statusline").setup()
    require('mini.surround').setup()
    require("mini.tabline").setup()
    require('mini.test').setup()
    require('mini.trailspace').setup()
    -- require('mini.visits').setup()

    local helper = require("helpers.mini")
    helper.setup_ai()
    helper.setup_clue()
    helper.setup_extra()
    helper.setup_hipatterns()
  end,
}

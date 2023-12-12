return {
  {
    "folke/tokyonight.nvim",
    version = "*",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme tokyonight-night')
    end,
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "markdown",
        "python",
        "java",
        "javascript",
        "typescript",
        "json",
        "lua",
        "vimdoc",
      },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    })
  end
}

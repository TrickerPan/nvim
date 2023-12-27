return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "python",
        "java",
        "swift",

        "html",
        "css",
        "javascript",
        "typescript",

        "json",
        "yaml",
        "toml",

        "markdown",

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

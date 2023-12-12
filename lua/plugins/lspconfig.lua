return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("helpers.python")
    lspconfig.pyright.setup({
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict",
            diagnosticMode = "workspace",
          },
          pythonPath = util.get_exec_path(),
        }
      },
    })
    lspconfig.tsserver.setup({})
    lspconfig.jdtls.setup({})
    lspconfig.lua_ls.setup({})
  end,
}

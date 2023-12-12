return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")
    local helpers = require("helpers.python")
    lspconfig.pyright.setup({
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict",
            diagnosticMode = "workspace",
          },
          pythonPath = helpers.get_exec_path(),
        }
      },
    })
    lspconfig.tsserver.setup {}
    lspconfig.jdtls.setup {}
    lspconfig.lua_ls.setup {}
  end,
}

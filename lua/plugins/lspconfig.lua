return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")
    local pyright = require("helpers.pyright")
    pyright.setup()
    lspconfig.tsserver.setup {}
    lspconfig.jdtls.setup {}
    lspconfig.lua_ls.setup {}
  end,
}

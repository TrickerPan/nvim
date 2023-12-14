return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")
    local pyright = require("helpers.pyright")
    pyright.setup()
    lspconfig.tsserver.setup {}
    lspconfig.jdtls.setup {}
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
  end,
}

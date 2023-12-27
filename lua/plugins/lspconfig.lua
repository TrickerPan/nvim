return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")
    local python = require("helpers.python")
    lspconfig.pyright.setup {
      cmd = python.pyright_cmd,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "strict",
          },
          pythonPath = python.path
        }
      }
    }
    lspconfig.jdtls.setup {}
    lspconfig.sourcekit.setup {}
    lspconfig.tsserver.setup {}
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

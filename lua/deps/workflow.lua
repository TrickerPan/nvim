local helpers = require('helpers.basic')
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later


now(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        checkout = 'master',
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    })
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline',
            'bash', 'powershell',
            'java', 'python', 'swift',
            'javascript', 'typescript', 'html', 'css',
            'xml', 'yaml', 'json', 'toml',
        },
        highlight = { enable = true },
    })
end)

later(function()
    add({
        source = 'neovim/nvim-lspconfig',
        checkout = 'master',
    })

    require("lspconfig.lua")
    require('lspconfig.java')
    require('lspconfig.python')
    require('lspconfig.typescript')
    require('lspconfig.tailwindcss')
end)

later(function()
    add({
        source = 'github/copilot.vim',
        checkout = 'release',
    })
    local map = helpers.keymap_set
    local command = helpers.is_mac and '<M-Tab>' or '<Tab>'
    map('i', command, 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = 'Accept Copilot suggestion'
    })

    vim.g.copilot_no_tab_map = true
end)

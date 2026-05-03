local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add({
        source = 'nvimtools/none-ls.nvim',
        checkout = 'main',
        depends = {
            {
                source = 'nvim-lua/plenary.nvim',
                checkout = 'master',
            },
            {
                source = 'nvimtools/none-ls-extras.nvim',
                checkout = 'main',
            },
        },
    })
    local null_ls = require("null-ls")
    null_ls.setup()
end)

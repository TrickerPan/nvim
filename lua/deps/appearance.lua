local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later


now(function()
    add({
        source = 'folke/tokyonight.nvim',
        checkout = 'main',
    })
    require('tokyonight').setup({
        style = 'night',
    })
    vim.cmd [[colorscheme tokyonight]]
end)

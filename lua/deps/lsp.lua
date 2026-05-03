local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add({
        source = 'neovim/nvim-lspconfig',
        checkout = 'master',
    })

    vim.lsp.enable({ 'lua_ls', 'ts_ls', 'pyright', 'jdtls', 'lemminx', 'svelte', 'tailwindcss' })
end)

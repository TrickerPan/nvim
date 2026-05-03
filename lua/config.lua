-- Encoding
vim.g.encding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Indent
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true

-- Popup completion
-- vim.keymap.set('i', '<Tab>', function()
--     return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
-- end, { expr = true })
-- vim.keymap.set('i', '<S-Tab>', function()
--     return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
-- end, { expr = true })
-- vim.keymap.set('i', '<CR>', function()
--     return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
-- end, { expr = true })

-- Customize Filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { ".zshrc", "*.zsh" },
    callback = function()
        vim.bo.filetype = "bash"
    end,
})

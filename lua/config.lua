-- Encoding
vim.g.encding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Indent
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true

-- Customize Shortcuts

-- Customize Filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { ".zshrc", "*.zsh" },
    callback = function()
        vim.bo.filetype = "bash"
    end,
})

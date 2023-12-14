-- Leader key: <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Custom keymaps

-- MiniPick
vim.keymap.set({"n", "v"}, "<leader>pf", "<cmd>lua MiniPick.builtin.files({ tool = 'git' })<cr>")
vim.keymap.set({"n", "v"}, "<leader>pb", "<cmd>lua MiniPick.builtin.buffers()<cr>")

-- MiniFiles
vim.keymap.set({"n", "v"}, "<leader>ff", "<cmd>lua MiniFiles.open()<cr>")


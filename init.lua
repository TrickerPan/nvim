-- require("core.basic")
-- require("core.plugins")
-- require("core.keymaps")

-- languages
-- require("core.python")

local package_path = vim.fn.stdpath('data') .. '/site/'
local snapshot_path = vim.fn.stdpath('config') .. '/mini-deps-snap'
local log_path = vim.fn.stdpath('log') .. '/mini-deps.log'
local mini_path = package_path .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({
  path = {
    package = package_path,
    snapshot = snapshot_path,
    log = log_path
  }
})

local add = MiniDeps.add

add({
  source = 'echasnovski/mini.nvim',
  checkout = 'stable',
})

require('deps.now')
require('deps.later')

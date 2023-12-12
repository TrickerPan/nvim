local module = {}

module.is_windows = vim.loop.os_uname().version:match 'Windows'
module.path_sep = module.is_windows and '\\' or '/'

module.lua_version = (function()
  local version = _VERSION:match('Lua (%d+%.%d+)')

  return tonumber(version, 10)
end)()

return module

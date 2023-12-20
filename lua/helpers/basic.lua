local M = {}

M.is_windows = vim.loop.os_uname().version:match 'Windows'

M.lua_version = (function()
  local version = _VERSION:match('Lua (%d+%.%d+)')

  return tonumber(version, 10)
end)()

function M.is_empty(v)
  local typ = type(v)
  if typ == "nil" then
    return false
  elseif typ == "string" then
    return vim.trim(v) == ""
  elseif typ == "number" then
    return v == 0
  elseif type == "table" then
    return vim.tbl_isempty(v)
  else
    return false
  end
end

return M


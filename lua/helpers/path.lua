local basic = require('helpers.basic')

local M = {}

M.sep = basic.is_windows and "\\" or "/"

M.home = (function()
  if basic.is_windows then
    return os.getenv("USERPROFILE")
  else
    return os.getenv("HOME")
  end
end)()

function M.root_dir(root_files)
  return vim.fs.dirname(vim.fs.find(root_files, {
    upward = true,
    stop = M.home,
  })[1])
end

function M.exists(path)
  local file_stat = vim.loop.fs_stat(path)
  if file_stat then
    return file_stat.type
  end
end

function M.is_dir(path)
  local typ = M.exists(path)
  return typ and typ == "directory" or false
end

function M.is_file(path)
  local typ = M.exists(path)
  return typ and typ == "file" or false
end

function M.join(...)
  return table.concat(vim.tbl_flatten { ... }, M.sep)
end


return M


local module = {}

module.is_windows = vim.loop.os_uname().version:match 'Windows'
module.path_sep = is_windows and '\\' or '/'

return module

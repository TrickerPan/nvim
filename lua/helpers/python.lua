local util = require("lspconfig.util")
local basic = require("helpers.basic")

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

local module = {}

function module.get_poetry_venv_dir()
  local output = vim.fn.system("poetry env info -p")
  if vim.v.shell_error ~= 0 then
    return
  end
  local venv_dir = output:match("([^\n]*)")
  return vim.fn.fnamemodify(venv_dir, ":p")
end

function module.get_venv_dir(root)
  local venv_dir = util.path.join(root, ".venv")
  if util.path.is_dir(venv_dir) then
    return venv_dir
  end

  venv_dir = util.path.join(root, "venv")
  if util.path.is_dir(venv_dir) then
    return venv_dir
  end

  venv_dir = module.get_poetry_venv_dir()
  if util.path.is_dir(venv_dir) then
    return venv_dir
  end
end

function module.get_exec_path()
  local file_ext = vim.fn.expand("%:e")
  if file_ext ~= "py" and file_ext ~= "pyi" then
    return
  end

  local cwd = vim.fn.getcwd()
  local root_dir = util.root_pattern(unpack(root_files))(cwd)
  if not root_dir then
    return
  end

  local venv_dir = module.get_venv_dir(root_dir)
  if not venv_dir then
    return
  end

  local python_exec = basic.is_windows and {"Scripts", "python"} or {"bin", "python"}

  return util.path.join(venv_dir, unpack(python_exec))
end

return module

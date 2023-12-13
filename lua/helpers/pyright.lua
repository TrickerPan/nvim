local util = require("lspconfig.util")
local basic = require("helpers.basic")

local default_exec_path = "python"

local is_root = (function()
  return util.root_pattern(
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git'
  ) ~= nil
end)()

local function gen_cmd()
  local cmd = {"pyright-langserver", "--stdio"}

  if is_root then
    local cwd = vim.fn.getcwd()
    table.insert(cmd, "--project")
    table.insert(cmd, cwd)
  end

  return cmd
end

local function get_poetry_venv_dir()
  local output = vim.fn.system("poetry env info -p")
  if vim.v.shell_error == 0 then
    local venv_dir = output:match("([^\n]*)")
    return vim.fn.fnamemodify(venv_dir, ":p")
  end
end

local function get_venv_dir()
  local venv_dir = get_poetry_venv_dir()
  if venv_dir ~= nil then
    return venv_dir
  end

  local cwd = vim.fn.getcwd()
  venv_dir = util.path.join(cwd, ".venv")
  if util.path.is_dir(venv_dir) then
    return venv_dir
  end

  venv_dir = util.path.join(cwd, "venv")
  if util.path.is_dir(venv_dir) then
    return venv_dir
  end
end

local function get_exec_path()
  if not is_root then
    return default_exec_path
  end

  local venv_dir = get_venv_dir()
  if not venv_dir then
    return default_exec_path
  end

  if basic.is_windows then
    return util.path.join(venv_dir, "Scripts", "python.exe")
  else
    return util.path.join(venv_dir, "bin", "python")
  end
end

local function setup()
  require("lspconfig").pyright.setup({
    cmd = gen_cmd(),
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "strict",
        },
        pythonPath = get_exec_path(),
      }
    }
  })
end

return {
  setup = setup
}


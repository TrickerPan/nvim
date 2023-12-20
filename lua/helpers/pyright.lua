local basic = require("helpers.basic")
local path = require("helpers.path")

local default_exec_path = "python"

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}

local root_dir = (function()
  return path.root_dir(root_files)
end)()

local function gen_cmd()
  local cmd = {"pyright-langserver", "--stdio"}

  if root_dir then
    table.insert(cmd, "--project")
    table.insert(cmd, root_dir)
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

  venv_dir = vim.fs.joinpath(root_dir, ".venv")
  if path.is_dir(venv_dir) then
    return venv_dir
  end

  venv_dir = vim.fs.joinpath(root_dir, "venv")
  if path.is_dir(venv_dir) then
    return venv_dir
  end
end

local function get_exec_path()
  local venv_dir = get_venv_dir()
  if not venv_dir then
    return default_exec_path
  end

  vim.print(venv_dir)
  if basic.is_windows then
    return path.join(venv_dir, "Scripts", "python.exe")
  else
    return path.join(venv_dir, "bin", "python")
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


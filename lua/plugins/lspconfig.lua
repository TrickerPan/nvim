local function get_poetry_dir()
  local poetry_handle = io.popen("poetry config cache-dir")
  local poetry_path = poetry_handle:read("*l")
  poetry_handle:close()
  return poetry_path .. "/virtualenvs"
end

local function get_project_name(project_path)
  return project_path:absolute():match("([^/]+)$")
end

local function get_poetry_venv_dir(project_path)
  local scan = require("plenary.scandir")

  local poetry_dir = get_poetry_dir()
  local project_name = get_project_name(project_path)
  local venvs = scan.scan_dir(poetry_dir, {
    only_dirs = true,
    depth = 1,
    search_pattern = project_name:gsub("-", "%%-") .. "*",
  })
  if #venvs > 0 then
    return venvs[1] .. "/bin/python"
  end
end

local function get_project_venv_dir(project_path)
  local venv_path = project_path:joinpath(".venv")
  if venv_path:exists() then
    return venv_path:absolute() .. "/bin/python"
  end
  venv_path = project_path:joinpath("venv")
  if venv_path:exists() then
    return venv_path:absolute() .. "/bin/python"
  end
end

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

local function get_project_path()
  local util = require("lspconfig.util")
  local path = require("plenary.path")

  local cwd = vim.fn.getcwd()
  local project_path = util.root_pattern(unpack(root_files))(cwd)

  if project_path then
    return path:new(project_path)
  end
end

local function get_python_path()
  local file_ext = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':e')
  if file_ext ~= "py" then
    return
  end

  project_path = get_project_path()
  local venv_dir = get_project_venv_dir(project_path)
  if not venv_dir then
    venv_dir = get_poetry_venv_dir(project_path)
  end

  return venv_dir
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.pyright.setup({
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict",
            diagnosticMode = "workspace",
          },
          pythonPath = get_python_path(),
        }
      },
    })
    lspconfig.tsserver.setup({})
    lspconfig.jdtls.setup({})
    lspconfig.lua_ls.setup({})
  end,
}

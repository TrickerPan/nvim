# README

## Plugins

- folke/lazy.nvim
- folke/tokyonight.nvim
- neovim/nvim-lspconfig.nvim
- github/copilot.vim
- echasnovski/mini.nvim
- nvim-tree/nvim-web-devicons
- lewis6991/gitsigns.nvim

## Installation

```shell
git clone https://github.com/TrickerPan/nvim.git ~/.config/nvim
```

## Setup

### Unix

Add the following content to `.bashrc` or `.profile` or `.zshrc` or etc.

```shell
alias vim="nvim"
alias vi="nvim"
```

### Windows

Add the following content to `$PROFILE`(Generally `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`)

```pwsh
function Start-Nvim {
    $config = $env:USERPROFILE + "\.config\nvim\init.lua"
    & nvim.exe -u $config $args
}

Set-Alias -Name nvim -Value Start-Nvim
Set-Alias -Name vim -Value Start-Nvim
Set-Alias -Name vi -Value Start-Nvim
```


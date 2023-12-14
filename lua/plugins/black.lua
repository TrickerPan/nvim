return {
  "psf/black",
  version = "*",
  config = function()
    vim.cmd [[
      augroup black_on_save
        autocmd!
        autocmd BufWritePre *.py Black
      augroup END
    ]]
  end
}


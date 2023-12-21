vim.cmd([[
augroup python
  autocmd!
  autocmd FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType python let g:python_indent = {}
  autocmd FileType python let g:python_indent.closed_paren_align_last_line = v:false
augroup END
]])

vim.g.pyindent_open_paren = vim.o.shiftwidth * 2
vim.g.pyindent_nested_paren = vim.o.shiftwidth
vim.g.pyindent_continue = vim.o.shiftwidth * 2


-- Remove trailing whitespaces
vim.api.nvim_create_autocmd(
  {'BufWritePre'},
  { pattern = {'*'}, command = '%s/\\s\\+$//e' }
)

-- Cleanup latex temp files
vim.api.nvim_create_autocmd(
  {'VimLeave'},
  { pattern = {'*.tex'}, command = '!texcleanup %' }
)

-- Config auto reloads
vim.api.nvim_create_autocmd(
  {'BufWritePost'},
  { pattern = {'.Xresources'}, command = '!xrdb merge % && moonctl xrdb' }
)
vim.api.nvim_create_autocmd(
  {'BufWritePost'},
  { pattern = {'config.xres'}, command = '!moonctl xrdb' }
)

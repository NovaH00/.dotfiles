-- Copy Absolute Path
vim.api.nvim_create_user_command('Cp', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  vim.notify('Absolute path copied to clipboard', vim.log.levels.INFO)
end, { desc = 'Copy current file absolute path' })

-- Copy Relative Path
vim.api.nvim_create_user_command('Cpr', function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('+', path)
  vim.notify('Relative path copied to clipboard', vim.log.levels.INFO)
end, { desc = 'Copy current file relative path' })

vim.api.nvim_create_user_command('Cppath', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy current file absolute path to clipboard' })

vim.api.nvim_create_user_command('CppathRel', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = 'Copy current file relative path to clipboard' })

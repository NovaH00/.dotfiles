local function copy_path(path, msg)
  vim.fn.setreg('+', path)
  vim.notify(msg, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('Cp', function()
  copy_path(vim.fn.expand('%:p'), 'Absolute path copied to clipboard')
end, { desc = 'Copy current file absolute path' })

vim.api.nvim_create_user_command('Cpr', function()
  copy_path(vim.fn.expand('%'), 'Relative path copied to clipboard')
end, { desc = 'Copy current file relative path' })

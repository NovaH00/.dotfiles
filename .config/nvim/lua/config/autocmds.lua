local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'VimEnter', 'BufEnter' }, {
  group = augroup('UpdateDirMtime', { clear = true }),
  callback = function()
    local path = vim.fn.expand('%:p')
    if vim.fn.isdirectory(path) == 1 then
      os.execute('touch ' .. vim.fn.shellescape(path))
    end
  end,
})

autocmd({ 'FocusGained', 'BufEnter' }, {
  group = augroup('Checktime', { clear = true }),
  callback = function(args)
    vim.cmd('silent! checktime')
    vim.api.nvim_exec_autocmds('BufReadPost', { buffer = args.buf })
  end,
})

autocmd('FileType', {
  group = augroup('QuickfixMaps', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', '<CR>', function()
      vim.cmd('.cc')
      vim.cmd('wincmd p')
    end, { buffer = true, silent = true })
  end,
})

autocmd('TermOpen', {
  group = augroup('TerminalSettings', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.colorcolumn = ''
    vim.opt_local.syntax = 'off'
  end,
})

autocmd('QuickFixCmdPost', {
  group = augroup('QuickfixWindow', { clear = true }),
  pattern = 'grep',
  callback = function()
    vim.cmd('cclose')
    vim.cmd('botright copen')
    vim.cmd('wincmd p')
    vim.cmd('quit')
  end,
})

autocmd('BufLeave', {
  group = augroup('CloseFinishedTerminal', { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    if vim.bo[bufnr].buftype ~= 'terminal' then
      return
    end
    local job = vim.b[bufnr].terminal_job_id
    if job and vim.fn.jobwait({ job }, 0)[1] ~= -1 then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) then
          pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
        end
      end)
    end
  end,
})

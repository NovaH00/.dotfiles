-- Run touch on the open directory to update the mtime
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("UpdateDirMtime", { clear = true }),
    callback = function()
        -- Get the path of the current buffer
        local path = vim.fn.expand("%:p")

        -- Check if it is a valid directory
        if vim.fn.isdirectory(path) == 1 then
          -- Execute 'touch' on the directory to update mtime
            os.execute("touch " .. vim.fn.shellescape(path))
          
        end
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = function(args)
    -- Check if file changed or was created externally
    vim.cmd("silent! checktime")

    -- Re-trigger BufReadPost so LSP can attach
    vim.api.nvim_exec_autocmds("BufReadPost", {
      buffer = args.buf,
    })
  end,
})

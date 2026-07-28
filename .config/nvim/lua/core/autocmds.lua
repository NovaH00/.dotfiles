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


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- Map <CR> (Enter) to jump but keep focus in quickfix
    vim.keymap.set("n", "<CR>", function()
      -- Execute the standard jump command
      vim.cmd(".cc") 
      -- Switch focus back to the previous window (the quickfix window)
      vim.cmd("wincmd p") 
    end, { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true }),
  callback = function()
    -- Disables the horizontal line highlight
    vim.opt_local.cursorline = false
    -- Disables the vertical margin column line
    vim.opt_local.colorcolumn = ""
    -- Disables standard Neovim syntax highlighting
    vim.opt_local.syntax = "off"
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "grep",
    callback = function()
        vim.cmd("cclose") -- just in case
        vim.cmd("botright copen")
        vim.cmd("wincmd p")
        vim.cmd("quit")
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    callback = function(args)
        local bufnr = args.buf

        if vim.bo[bufnr].buftype ~= "terminal" then
            return
        end

        -- Only close finished terminals
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

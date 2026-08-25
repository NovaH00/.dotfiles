return {
  "junegunn/vim-easy-align",
  config = function()
    vim.keymap.set("x", "ga", function()
      local pattern = vim.fn.input("Pattern: ")

      if pattern == "" then
        return
      end

      -- 1. Press <Esc> (\27) to exit visual mode and set the '< and '> marks
      vim.cmd("normal! \27")

      -- 2. Now '<,'> works, and your pattern is automatically wrapped in /.../
      vim.cmd("'<,'>EasyAlign /" .. vim.fn.escape(pattern, "/") .. "/")
    end, { silent = true })
  end,
}

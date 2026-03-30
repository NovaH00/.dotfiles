return {
  {
    "Vigemus/iron.nvim",
    config = function()
      local iron = require("iron.core")

      -- Python REPL fallback resolver
      local function python_repl()
        if vim.fn.executable("uv") == 1 then
          if vim.fn.executable("ipython") == 1 then
            return { "uv", "run", "ipython" }
          end
          return { "uv", "run", "python" }
        end

        if vim.fn.executable("ipython") == 1 then
          return { "ipython" }
        end

        if vim.fn.executable("python3") == 1 then
          return { "python3" }
        end

        return { "python" }
      end

      iron.setup({
        config = {
          repl_definition = {
            sh = {
              command = {"zsh"}
            },
            python = {
              command = python_repl()
            }
          },
          repl_open_cmd = "vertical botright 60 split"
        },
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
      })
    end
  }
}

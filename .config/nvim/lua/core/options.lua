vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.autoread = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.list = true

vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldenable = true

vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = function(lines, _)
      local text = table.concat(lines, "\n")
      local handle = io.popen("xclip -selection clipboard -in", "w")
      handle:write(text)
      handle:close()
    end,
    ["*"] = function(lines, _)
      local text = table.concat(lines, "\n")
      local handle = io.popen("xclip -selection primary -in", "w")
      handle:write(text)
      handle:close()
    end,
  },
  paste = {
    ["+"] = function()
      local handle = io.popen("xclip -selection clipboard -out", "r")
      local result = handle:read("*a")
      handle:close()
      return vim.split(result, "\n")
    end,
    ["*"] = function()
      local handle = io.popen("xclip -selection primary -out", "r")
      local result = handle:read("*a")
      handle:close()
      return vim.split(result, "\n")
    end,
  },
}

-- venv that installed pynvim and stuff for other plugins
vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

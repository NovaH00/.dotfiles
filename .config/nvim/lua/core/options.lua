vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.autoread = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.list = true
vim.opt.splitright = true
vim.opt.equalalways = true
vim.opt.conceallevel = 2
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.foldenable = true


-- venv that installed pynvim and stuff for other plugins
vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

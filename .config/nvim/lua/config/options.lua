local opt = vim.opt

opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.number = true
opt.relativenumber = true
opt.clipboard = 'unnamedplus'
opt.cursorline = true

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.autoread = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.list = true
opt.splitright = true
opt.equalalways = true

opt.conceallevel = 2
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.foldenable = true

opt.whichwrap:append('<>[]hl')

vim.g.python3_host_prog = vim.fn.expand('~/.virtualenvs/neovim/bin/python3')

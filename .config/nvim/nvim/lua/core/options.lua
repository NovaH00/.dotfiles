vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.clipboard = 'unnamedplus'

vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = { "xclip", "-selection", "clipboard" },
    ["*"] = { "xclip", "-selection", "clipboard" },
  },
  paste = {
    ["+"] = { "xclip", "-selection", "clipboard", "-o" },
    ["*"] = { "xclip", "-selection", "clipboard", "-o" },
  },
}

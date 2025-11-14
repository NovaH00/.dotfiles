vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.clipboard = 'unnamedplus'

vim.g.clipboard = {
  name = "OSC52",
  copy = {
    ["+"] = function(lines, _)
      require("vim.ui.clipboard.osc52").copy("+")(lines)
    end,
    ["*"] = function(lines, _)
      require("vim.ui.clipboard.osc52").copy("*")(lines)
    end,
  },
  paste = {
    ["+"] = function()
      return require("vim.ui.clipboard.osc52").paste("+")()
    end,
    ["*"] = function()
      return require("vim.ui.clipboard.osc52").paste("*")()
    end,
  },
}


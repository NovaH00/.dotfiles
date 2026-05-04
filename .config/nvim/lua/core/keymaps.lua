-- Allow wrapping at the start/end of the line
vim.opt.whichwrap:append('<,>,[,],h,l')  
--Toggle wrapping
vim.api.nvim_set_keymap('n', '<leader>w', ':set wrap!<CR>', { noremap = true, silent = true })

-- Indent with Tab
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })

-- Outdent with Shift+Tab
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true, silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "gl", "g_", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "gh", "0",  { noremap = true, silent = true })

-- ESC exit the search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- LSP diagnostic
vim.keymap.set('n', '<A-d>', vim.diagnostic.open_float, { noremap = true, silent = true })

-- ESC to escape terminal mode 
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Ctrl + l to jump forward instead of Ctrl + i
vim.keymap.set('n', '<C-l>', '<C-i>', { noremap = true, silent = true })

-- Show/hide hidden items in oil.nvim
vim.keymap.set("n", "H", function()
  require("oil").toggle_hidden()
end, { desc = "Oil: toggle hidden files" })

vim.keymap.set("x", "p", '"_dp', { desc = "Paste without overwriting register" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yanking (black hole)" })
vim.keymap.set("x", "x", '"_d', { desc = "Delete selection without yanking (black hole)" })
vim.keymap.set("n", "xx", '"_dd', { desc = "Delete the line without yanking (black hole)" })

-- Allow wrapping at the start/end of the line
vim.opt.whichwrap:append('<,>,[,],h,l')  
-- Arrow key mappings for Normal, Insert, and Visual modes
vim.keymap.set({'n', 'i', 'v'}, '<A-j>', '<Left>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<A-l>', '<Right>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<A-k>', '<Down>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<A-i>', '<Up>', { noremap = true, silent = true })

-- Indent with Tab
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })

-- Outdent with Shift+Tab
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })


-- Add new line when in insert mode and go past end of file
local function new_line_below()
  local keys = vim.api.nvim_replace_termcodes('<Esc>o<Esc>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

vim.keymap.set('i', '<A-k>', function()
  if vim.fn.line('.') == vim.fn.line('$') then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>o', true, false, true), 'n', false)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, false, true), 'n', false)
  end
end, { noremap = true, silent = true })


-- Toggle neo-tree with Ctrl + N
vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")

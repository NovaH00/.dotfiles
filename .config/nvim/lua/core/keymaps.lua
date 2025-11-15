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
vim.keymap.set("n", "<C-p>", "<cmd>Neotree toggle<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })

-- In normal mode, 9 to go to start line, 0 to go to end line
vim.keymap.set({'n', 'v'}, '9', '^', { noremap = true, silent = true })
vim.keymap.set({'n', 'v'}, '0', '$', { noremap = true, silent = true })

-- Remove nvim builtin keymap for <Tab> and <S-Tab> so it
-- doesn't interfere with nvim cmp
vim.keymap.del("i", "<Tab>")
vim.keymap.del("s", "<Tab>")
vim.keymap.del("i", "<S-Tab>")
vim.keymap.del("s", "<S-Tab>")
-- Overwrite C-f (page up) and C-b (page down) since we using tmux and neotree has f for search
vim.keymap.set("n", "<C-f>", "<Nop>")
vim.keymap.set("n", "<C-b>", "<Nop>")

-- ESC exit the search 
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Remap Ctrl+w + j/k/i/l to act like h/j/k/l
vim.keymap.set('n', '<C-w>j', '<C-w>h', { noremap = true, silent = true })  -- move to left split
vim.keymap.set('n', '<C-w>k', '<C-w>j', { noremap = true, silent = true })  -- move to down split
vim.keymap.set('n', '<C-w>i', '<C-w>k', { noremap = true, silent = true })  -- move to up split
vim.keymap.set('n', '<C-w>l', '<C-w>l', { noremap = true, silent = true })  -- move to right split


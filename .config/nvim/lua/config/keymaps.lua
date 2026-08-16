local map = vim.keymap.set

map('n', '<leader>w', ':set wrap!<CR>', { desc = 'Toggle line wrap' })

map('n', '<Tab>', '>>', { desc = 'Indent line' })
map('v', '<Tab>', '>gv', { desc = 'Indent selection' })
map('n', '<S-Tab>', '<<', { desc = 'Outdent line' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent selection' })

map({ 'n', 'v' }, 'gl', 'g_', { desc = 'End of line' })
map({ 'n', 'v' }, 'gh', '0', { desc = 'Start of line' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Leave terminal insert mode' })

map('n', '<C-l>', '<C-i>', { desc = 'Jump forward (like <C-i>)' })

map('x', 'p', '"_dP', { desc = 'Paste without overwriting register' })
map('n', 'x', '"_x', { desc = 'Delete char to black hole register' })
map('x', 'x', '"_d', { desc = 'Delete selection to black hole register' })
map('n', 'xx', '"_dd', { desc = 'Delete line to black hole register' })

map('n', 't', ':term ', { desc = 'Open terminal' })

map('n', 'gf', 'gF', { desc = 'Open file under cursor' })
map('n', 'gF', 'gf', { desc = 'Open file under cursor (split)' })

map('x', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('x', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('n', 'J', 'mzJ`z', { desc = 'Join line, keep cursor' })

map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down, center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up, center' })

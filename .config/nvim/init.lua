require("core.options")
require("core.keymaps")
require("core.autocmds")

require("lazy_setup")

-- Normal & Visual mode cursor (dimmer yellow)
vim.cmd("highlight Cursor guibg=#da7756")

-- Insert mode cursor (bright yellow)
vim.cmd("highlight CursorInsert guibg=#ffdd33")

-- Apply guicursor to use these highlights
vim.opt.guicursor = table.concat({
    "n-v-c:block-Cursor",       -- Normal / Visual / Command: block with dimmer yellow
    "i-ci-ve:block-CursorInsert", -- Insert / Cmdline Insert: block with bright yellow
    "r-cr:hor20",               -- Replace: horizontal bar
    "o:hor50",                  -- Operator-pending: horizontal bar
}, ",")

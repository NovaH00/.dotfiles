return {
  "haya14busa/vim-asterisk",
  keys = {
    -- Visual Mode: Map * and # to the "z" variant (Does NOT jump)
    { "*", "<Plug>(asterisk-z*)", mode = "x", desc = "Search Selection (Stay)" },
    { "#", "<Plug>(asterisk-z#)", mode = "x", desc = "Search Selection Backward (Stay)" },

    -- Normal Mode: Map * and # to the "z" variant (Optional, for consistency)
    { "*", "<Plug>(asterisk-z*)", mode = "n", desc = "Search Word (Stay)" },
    { "#", "<Plug>(asterisk-z#)", mode = "n", desc = "Search Word Backward (Stay)" },
  },
  config = function()
    -- Optional: Keeps the cursor position relative to the match 
    -- when iterating with n/N later
    vim.g['asterisk#keeppos'] = 1
  end
}

return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false, 
      }
    })
    vim.keymap.set('n', 'K', '<CMD>Lspsaga hover_doc<CR>')
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  }
}

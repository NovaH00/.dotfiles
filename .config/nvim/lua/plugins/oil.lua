return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,

  keys = {
    {
      '<C-p>',
      function()
        if vim.bo.filetype == 'oil' then
          require('oil').close()
        else
          require('oil').open()
        end
      end,
      desc = 'Toggle oil',
    },
    {
      'H',
      function()
        require('oil').toggle_hidden()
      end,
      desc = 'Oil: toggle hidden files',
    },
  },

  config = function()
    function _G.get_oil_winbar()
      local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
      local dir = require('oil').get_current_dir(bufnr)

      local path = ''
      if dir then
        path = vim.fn.fnamemodify(dir, ':~')
      else
        path = vim.api.nvim_buf_get_name(bufnr)
      end

      return '%#OilWinBarPath# ' .. path .. ' %*'
    end

    vim.api.nvim_set_hl(0, 'OilWinBarPath', {
      bg = 'NONE',
      fg = '#da7754',
      bold = true,
    })
    vim.api.nvim_set_hl(0, 'WinBar', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'Normal' })

    require('oil').setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,

      win_options = {
        winbar = '%!v:lua.get_oil_winbar()',
      },

      columns = {
        'permissions',
        'size',
        {
          'mtime',
          format = '%d/%m/%y-%H:%M:%S',
        },
        'icon',
      },

      layout = {
        padding = 2,
        max_width = 90,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },

      view_options = {
        show_hidden = false,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
        is_always_hidden = function(name, _)
          local hidden_names = { '__pycache__' }
          local hidden_patterns = { '%.pyc$' }
          for _, hidden in ipairs(hidden_names) do
            if name == hidden then
              return true
            end
          end
          for _, pattern in ipairs(hidden_patterns) do
            if name:match(pattern) then
              return true
            end
          end
          return false
        end,
      },

      keymaps = {
        ['q'] = 'actions.close',
        ['<C-p>'] = 'actions.close',
        ['<CR>'] = 'actions.select',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['g?'] = 'actions.show_help',
      },
    })
  end,
}

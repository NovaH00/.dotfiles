return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source
    "hrsh7th/cmp-buffer",   -- Text in current buffer source
    "hrsh7th/cmp-path",     -- File system paths source
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.preselect = cmp.PreselectMode.None

    opts.completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    }
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp" }, 
      { name = "buffer" },   
      { name = "path" },    
    })

    opts.completion = {
      autocomplete = { cmp.TriggerEvent.TextChanged },
    }

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.snippet.active({ direction = 1 }) then
          vim.schedule(function() vim.snippet.jump(1) end)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.snippet.active({ direction = -1 }) then
          vim.schedule(function() vim.snippet.jump(-1) end)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    return opts
  end,
}

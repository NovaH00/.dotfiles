return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<Esc>"] = actions.close,
          },
        },
      },
    })
  end,
}

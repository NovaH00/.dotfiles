return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = {
      rocks = { "magick" }, 
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_rock",
        integrations = {
          markdown = {
            enabled = false,
          },
          neorg = { enabled = false },
          typst = { enabled = false },
          html = { enabled = false },
          css = { enabled = false },
        },
        max_width = 100, -- tweak to preference
        max_height = 12, -- ^
        max_height_window_percentage = math.huge, -- this is necessary for a good experience
        max_width_window_percentage = math.huge,
      })
    end,
  },
}

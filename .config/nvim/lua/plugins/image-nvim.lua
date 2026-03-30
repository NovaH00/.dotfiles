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
          -- FIX: This stops images from showing up inside markdown links
          markdown = {
            enabled = false,
          },
          -- Also disabling others you likely don't want auto-rendering in
          neorg = { enabled = false },
          typst = { enabled = false },
          html = { enabled = false },
          css = { enabled = false },
        },
        -- Optional: Adjust how images look when you open an actual image file
        max_height_window_percentage = 50,
      })
    end,
  },
}

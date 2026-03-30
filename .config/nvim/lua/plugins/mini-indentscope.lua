return {
  "echasnovski/mini.indentscope",
  version = false, 
  opts = function()
    return {
      symbol = "▏",
      options = { try_as_border = true }, 
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    }
  end,
  config = function(_, opts)
    require("mini.indentscope").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        -- This tells mini.indentscope to override the global settings 
        -- for this specific buffer only
        vim.b.miniindentscope_config = {
          options = { try_as_border = false },
        }
      end,
    })
  end,
}

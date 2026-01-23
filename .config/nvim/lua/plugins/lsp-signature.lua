return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = function()
    require("lsp_signature").setup({
      bind = true,                -- Mandatory, auto binds to LSP
      floating_window = true,     -- Show signature in a floating window
      hint_prefix = "", 
      handler_opts = {
        border = "rounded"        -- Rounded border for floating window
      },
      zindex = 50,                -- Make sure it appears above other windows
      extra_trigger_chars = {","}, -- Trigger on comma too
      always_trigger = true, 
    })
  end
}

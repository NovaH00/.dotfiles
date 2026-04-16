return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = function()
    require("lsp_signature").setup({
      bind = true,                
      floating_window = true,     
      hint_prefix = "", 
      handler_opts = {
        border = "rounded"        
      },
      zindex = 50,                
      extra_trigger_chars = {","},
      always_trigger = true, 
    })
  end
}

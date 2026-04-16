return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "c",
        "python",
        "cpp",
        "rust",
        "javascript",
        "typescript",
        "markdown",        
        "markdown_inline",
      },
      highlight = { 
        enable = true, 
        additional_vim_regex_highlighting = false 
      },
      indent = {
        enable = true,
      },
    })

  end,
}

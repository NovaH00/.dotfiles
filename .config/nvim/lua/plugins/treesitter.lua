return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()

    local ensure_installed = {
      "python",
      "lua",
      "rust",
      "go",
      "c",
      "cpp",
      "javascript",
      "typescript",
      "make",
      "dockerfile",
    }

    ts.install(ensure_installed)

    local ts_highlight_group = vim.api.nvim_create_augroup(
      "TreesitterHighlight",
      { clear = true }
    )

    vim.api.nvim_create_autocmd("FileType", {
      group = ts_highlight_group,
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and vim.treesitter.language.add(lang) then
          pcall(vim.treesitter.start, args.buf, lang)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}

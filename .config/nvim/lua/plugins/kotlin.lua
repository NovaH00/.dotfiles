return {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "stevearc/oil.nvim",
        "folke/trouble.nvim",
    },
    config = function()
      require("kotlin").setup({
          jdk_for_symbol_resolution = "/usr/lib/jvm/java-21-openjdk-amd64",
          build_tool = "gradle",               -- or "maven"
          jvm_args = { "-Xmx4g" },
          inlay_hints = { enabled = false },
      })
    end,
}

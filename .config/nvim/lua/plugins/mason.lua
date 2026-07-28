return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        require("mason").setup({
            ui = {
                icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
            },
        })

        local mason_lsp = require("mason-lspconfig")
        mason_lsp.setup({
            ensure_installed = {
                "basedpyright",
                "clangd",
                "ruff",
                "neocmake",
                "ts_ls",
            },
        })

        local mason_lsp = require("mason-lspconfig")
    end,
}


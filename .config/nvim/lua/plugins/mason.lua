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
                "rust_analyzer",
                "basedpyright",
                "clangd",
                "ruff",
                "neocmake",
                "ts_ls",
                "docker_language_server",
                "docker_compose_language_service",
            },
        })
    end,
}


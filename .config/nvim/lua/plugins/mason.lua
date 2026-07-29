return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        require("mason").setup({
            ui = {
                icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
            },
        })

        vim.lsp.config("*", {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                {
                    textDocument = {
                        completion = {
                            completionItem = {
                                snippetSupport = false,
                            },
                        },
                    },
                }
            ),
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "basedpyright",
                "clangd",
                "ruff",
                "neocmake",
                "ts_ls",
            },
        })
    end,
}

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local lsp = require("lsp-zero").preset({
                name="minimal",
                set_lsp_keymaps=true,
                manage_nvim_cmp=true,
                suggest_lsp_servers=false,
            })
            lsp.setup()
        end,
    },
}

return {
    { "blazkowolf/gruber-darker.nvim" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    { "williamboman/mason.nvim", version = "*" , config = true },
    { "williamboman/mason-lspconfig.nvim", version = "*" },    
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    { "nvim-neo-tree/neo-tree.nvim" },
    { "numToStr/Comment.nvim" },
    { "chikko80/error-lens.nvim" },
}

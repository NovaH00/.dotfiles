return {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
        -- these are examples, not mandatory
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
    config = function()
        vim.keymap.set("n", "<space>mi", ":MoltenInit<CR>",
            { silent = true, desc = "Initialize the plugin" })

        vim.keymap.set("n", "<space>e", ":MoltenEvaluateOperator<CR>",
            { silent = true, desc = "run operator selection" })

        vim.keymap.set("n", "<space>rl", ":MoltenEvaluateLine<CR>",
            { silent = true, desc = "evaluate line" })

        vim.keymap.set("n", "<space>rr", ":MoltenReevaluateCell<CR>",
            { silent = true, desc = "re-evaluate cell" })

        vim.keymap.set("v", "<space>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
            { silent = true, desc = "evaluate visual selection" })
    end,
}

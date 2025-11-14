return {
    "blazkowolf/gruber-darker.nvim", 
    config = function()
        require("gruber-darker").setup({
            bold = true,
            italic = {
                strings = false, 
                comments = false, 
                keywords = false,
            },
        })

        vim.cmd.colorscheme("gruber-darker")   
    end
}

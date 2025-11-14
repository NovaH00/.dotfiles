return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
    require("neo-tree").setup({
        filesystem = {    
            hijack_netrw_behavior = "open_default",
        },
        close_if_last_window = true, 
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          container = { enable_character_fade = true },
          name = { truncation = { length = 40 } },
        },
        window = { 
            width = 50, 
            position = "float" 
        },
        follow_current_file = { 
            leave_dirs_open = true,
        }
    })
    end,
}


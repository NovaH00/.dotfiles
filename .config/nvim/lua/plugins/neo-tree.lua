return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
    require("neo-tree").setup({
      close_if_last_window = true, 
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      window = { 
          width = 50, 
          position = "float",
      },

      filesystem = {
        window = {
            mappings = {
                ["f"] = "telescope_find",
                ["<C-f>"] = false,
            }
        },
        
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
      },
      
      commands = {
          telescope_find = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                require('telescope.builtin').find_files({
                    cwd = path, -- Sets the current working directory for the search
                })
          end,

          -- Custom command to run Telescope's live_grep rooted in the selected folder
          telescope_grep = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                require('telescope.builtin').live_grep({
                    cwd = path,
                })
          end,
      },

      -- Set default configs
      default_component_configs = {
        container = { enable_character_fade = true },
        name = { truncation = { length = 40 } },
        git_status = {
          symbols = {
            added     = "✚", 
            deleted   = "✖",
            modified  = "",
            renamed   = "-",
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          },
          align = "right",
        },
      },
      
    })
    end,
}

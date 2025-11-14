return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        -- Ensure 'nvim-telescope/telescope.nvim' is also listed here
    },
    config = function()
    require("neo-tree").setup({
      close_if_last_window = true, 
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      -- Set general window options
      window = { 
          width = 50, 
          position = "float",
      },

      -- Set filesystem-specific options (including the correct location for mappings)
      filesystem = {
        -- This is the correct location for mappings
        window = {
            mappings = {
                ["f"] = "telescope_find", -- Use 'f' to launch Telescope's find_files
                ["tg"] = "telescope_grep", -- Use 'tg' to launch Telescope's live_grep
                -- If you wanted to map '/' here, it would be ["/"] = "telescope_find",
            }
        },
        
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true, -- Corrected: You had this config repeated below
        },
        use_libuv_file_watcher = true,
      },
      
      -- Define the custom commands
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

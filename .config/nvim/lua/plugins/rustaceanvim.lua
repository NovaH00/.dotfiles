return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = { "env", "RUSTUP_TOOLCHAIN=stable", "rust-analyzer" },

        settings = {
          ["rust-analyzer"] = {
            completion = {
              termSearch = {
                enable = false,
              },
            },
            diagnostics = {
              disabled = { 'typed-hole' },
            },
            assist = {
              termSearch = {
                fuel = 0,
              },
            },
          },
        },

        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
              },
            },
          },
        },
      },

      tools = {
        hover_actions = {
          enable = false,
        },
      },
    }
  end,
}

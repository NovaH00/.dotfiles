return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = { "env", "RUSTUP_TOOLCHAIN=stable", "rust-analyzer" },
      },
      tools = {
        hover_actions = {
          enable = false,
        },
      },
    }
  end,
}

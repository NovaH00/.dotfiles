return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
        extraArgs = {
          "--",
          "-W", "clippy::unwrap_used",
          "-W", "clippy::expect_used",
        },
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}


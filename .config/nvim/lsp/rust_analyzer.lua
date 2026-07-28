return {
  cmd = { vim.fn.expand("~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer") },
  filetypes = { "rust" },
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


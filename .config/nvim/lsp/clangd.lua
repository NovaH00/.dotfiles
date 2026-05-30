return {
  cmd = {
    "clangd",
    "--background-index",
    "--query-driver=" .. vim.env.HOME .. "/.platformio/packages/toolchain-*/bin/*",
    "--compile-commands-dir=.",
  },
  filetypes = { "c", "cpp", "cuda" },
  root_markers = {
    "platformio.ini",
    ".git",
    ".clangd",
    "compile_commands.json",
  },
}

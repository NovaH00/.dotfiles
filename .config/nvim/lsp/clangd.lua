return {
  cmd = {
    "clangd",
    "--background-index",
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

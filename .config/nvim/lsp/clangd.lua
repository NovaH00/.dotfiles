return {
  cmd = {
    "clangd",
  },
  filetypes = { "c", "cpp" },
  root_markers = {
    "compile_commands.json",
    "platformio.ini",
    ".git",
  },
  settings = {
    clangd = {
      fallbackFlags = {
        "-std=gnu++17",
      },
    },
  },
}

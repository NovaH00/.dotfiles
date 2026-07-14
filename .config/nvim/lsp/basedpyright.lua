return {
  cmd = {
    "basedpyright-langserver",
    "--stdio",
  },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
    ".basedpyrightconfig.json",
  },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
}

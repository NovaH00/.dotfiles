return {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift" },
  root_markers = {
    "Package.swift",
    ".git",
  },
  get_language_id = function(_, filetype)
    return filetype
  end,
}

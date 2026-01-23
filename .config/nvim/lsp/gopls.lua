return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },

  root_markers = {
    "go.work",
    "go.mod",
    ".git",
  },

  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
        nilness = true,
        shadow = true,
        unreachable = true,
        useany = true,
        ST1003 = true, -- poor naming (staticcheck)
        ST1016 = true, -- redundant type conversion
      },

      -- Module behavior
      completeUnimported = true,
      usePlaceholders = true,
      deepCompletion = true,

      -- Codelens (optional but useful)
      codelenses = {
        gc_details = true,
        generate = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },

      -- Directory filters (optional)
      directoryFilters = {
        "-.git",
        "-node_modules",
      },
    },
  },
}

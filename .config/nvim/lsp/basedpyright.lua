return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'recommended',
        autoImportCompletions = false,
        diagnosticSeverityOverrides = {
          reportArgumentType = "error",
          reportFunctionMemberAccess = false,
          reportUnusedImport = "hint",
          reportIndexIssue = "error",
          reportDeprecated = "error",
          reportAssignmentType = "error",
          reportReturnType = "error",
          reportOptionalMemberAccess = "warning",
          reportAny = false,
          reportExplicitAny = false,
          reportMissingTypeStubs = false,
          reportIgnoreCommentWithoutRule = false,
          reportCallInDefaultInitializer = false,
          reportUnknownMemberType = false,
        }
      },
    },
  },
}


return {
  'williamboman/mason.nvim',
  dependencies = { 'williamboman/mason-lspconfig.nvim' },
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    require('mason-lspconfig').setup({
      ensure_installed = {
        'clangd',
        'ruff',
        'neocmake',
        'ts_ls',
        'jdtls',
      },
      automatic_enable = {
        exclude = { 'rust_analyzer' },
      },
    })
  end,
}

vim.lsp.config('*', {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = false,
          },
        },
      },
    }
  ),
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
  callback = function(ev)
    local buf = ev.buf

    vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = buf, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('gt', vim.lsp.buf.type_definition, 'Go to type definition')
    map('gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('gr', vim.lsp.buf.references, 'List references')
    map('K', function()
      vim.lsp.buf.hover({ border = 'rounded' })
    end, 'LSP hover')
    map('<A-d>', vim.diagnostic.open_float, 'Open diagnostic float')
  end,
})

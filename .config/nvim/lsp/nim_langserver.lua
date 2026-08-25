---@brief
---
--- https://github.com/nim-lang/langserver
---
--- `nim-langserver` can be installed via the `nimble` package manager:
--- ```sh
--- nimble install nimlangserver
--- ```

---@type vim.lsp.Config
return {
  cmd = { 'nimlangserver' },
  filetypes = { 'nim' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local nimble = vim.fs.find(function(name)
      return name:match('%.nimble$') ~= nil
    end, { path = fname, upward = true })[1]
    on_dir(
      (nimble and vim.fs.dirname(nimble))
      or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    )
    end,

    handlers = {
      ['window/showMessage'] = function(_, params)
        if params.type > vim.lsp.protocol.MessageType.Warning then
          return  -- drop Info/Log noise ("Nimsuggest initialized ...")
        end
        return vim.lsp.handlers['window/showMessage'](nil, params, {
          client_id = vim.lsp.get_client_by_name('nim_langserver') and vim.lsp.get_client_by_name('nim_langserver').id,
        })
      end,
    },
  }

local indent = {
  lua = 2,
  javascript = 2,
  javascriptreact = 2,
  typescriptreact = 2,
  python = 4,
  rust = 4,
  kotlin = 4,
  typescript = 4,
  java = 4,
}

local function apply_indent()
  local sw = indent[vim.bo.filetype]
  if sw then
    vim.bo.expandtab = true
    vim.bo.shiftwidth = sw
    vim.bo.tabstop = sw
    vim.bo.softtabstop = sw
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('IndentSettings', { clear = true }),
  callback = apply_indent,
})

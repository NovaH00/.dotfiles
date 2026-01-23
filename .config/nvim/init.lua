require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.usercmds")

require("lazy_setup")

-- Define the function to strip backslashes
local function clean_hover_text(s)
  if not s then return "" end
  -- 1. Remove backslashes before underscores: \_ -> _
  s = s:gsub("\\_", "_")
  -- 2. Remove backslashes before brackets: \[ -> [ and \] -> ]
  s = s:gsub("\\[", "["):gsub("\\]", "]")
  -- 3. (Optional) Remove ALL backslashes if the above isn't enough:
  -- s = s:gsub("\\", "") 
  return s
end

-- Override the default LSP hover handler
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method

  if not (result and result.contents) then
    return -- No content to display
  end

  -- Edit the result content before showing it
  local contents = result.contents
  if type(contents) == "table" and contents.kind == "markdown" then
    contents.value = clean_hover_text(contents.value)
  elseif type(contents) == "table" and (contents.kind == "plaintext" or not contents.kind) then
    if type(contents.value) == "string" then
       contents.value = clean_hover_text(contents.value)
    end
    -- Handle array of strings (older servers)
    for i, line in ipairs(contents) do
      if type(line) == "string" then
        contents[i] = clean_hover_text(line)
      end
    end
  elseif type(contents) == "string" then
    result.contents = clean_hover_text(contents)
  end

  -- Call the default handler with the modified result
  return vim.lsp.handlers.hover(_, result, ctx, config)
end

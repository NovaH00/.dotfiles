return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    note_id_func = function(title, dir)
      return require("obsidian.builtin").title_id(title, dir)
    end,
    workspaces = {
      {
        name = "main",
        path = "/home/nova/vault",
        strict = true,
      },
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    local commands = require("obsidian.commands")
    commands.commands["new"].complete = function(_, cmdline)
      local vault = "/home/nova/vault"
      local partial = cmdline:match("^%S+%s+new%s+(.*)$") or ""
      local dir, prefix = vault, partial
      if partial:find("/") then
        local parent = partial:match("^(.*/)")
        dir = vault .. "/" .. parent:sub(1, -2)
        prefix = partial:sub(#parent + 1)
      end
      local results = {}
      local ok, iter = pcall(vim.fs.dir, dir)
      if ok then
        for name, type in iter do
          if name:sub(1, #prefix) == prefix then
            local entry = (partial:match("^(.*/)") or "") .. name
            table.insert(results, entry)
          end
        end
      end
      return results
    end
  end,
}

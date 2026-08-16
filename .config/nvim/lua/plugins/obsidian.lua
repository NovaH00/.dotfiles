return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  opts = {
    legacy_commands = false,
    note_id_func = function(title, dir)
      return require('obsidian.builtin').title_id(title, dir)
    end,
    workspaces = {
      {
        name = 'main',
        path = '/home/nova/vault',
        strict = true,
      },
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    local vault = '/home/nova/vault'
    local complete = function(_, cmdline, cmd)
      local partial = cmdline:match('^%S+%s+' .. cmd .. '%s+(.*)$') or ''
      local unescaped = partial:gsub('\\([ ,\t])', '%1')
      local parent = unescaped:match('^(.*/)') or ''
      local dir = parent ~= '' and (vault .. '/' .. parent:sub(1, -2)) or vault
      local prefix = parent ~= '' and unescaped:sub(#parent + 1) or unescaped
      local results = {}
      local ok, iter = pcall(vim.fs.dir, dir)
      if ok then
        for name, _ in iter do
          if name:sub(1, 1) ~= '.' and name:sub(1, #prefix) == prefix then
            table.insert(results, (partial:match('^(.*/)') or '') .. name)
          end
        end
      end
      return results
    end

    local commands = require('obsidian.commands')
    commands.commands['new'].complete = function(_, cmdline)
      return complete(_, cmdline, 'new')
    end
    commands.commands['open'].complete = function(_, cmdline)
      return complete(_, cmdline, 'open')
    end
  end,
}

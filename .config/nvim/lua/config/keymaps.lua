local map = vim.keymap.set

map('n', '<leader>w', ':set wrap!<CR>', { desc = 'Toggle line wrap' })

map('n', '<Tab>', '>>', { desc = 'Indent line' })
map('v', '<Tab>', '>gv', { desc = 'Indent selection' })
map('n', '<S-Tab>', '<<', { desc = 'Outdent line' })
map('v', '<S-Tab>', '<gv', { desc = 'Outdent selection' })

map({ 'n', 'v' }, 'gl', 'g_', { desc = 'End of line' })
map({ 'n', 'v' }, 'gh', '0', { desc = 'Start of line' })

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Leave terminal insert mode' })

local term_history = {}
local term_win = nil

local function close_term_output()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    local buf_to_del = vim.api.nvim_win_get_buf(term_win)
    local inside_term = (vim.api.nvim_get_current_win() == term_win)
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    if buf_to_del and vim.api.nvim_buf_is_valid(buf_to_del) then
      pcall(vim.api.nvim_buf_delete, buf_to_del, { force = true })
    end
    return inside_term
  end
  return false
end

local function jump_backward()
  local was_inside = close_term_output()
  if not was_inside then
    local count = vim.v.count1
    local keys = vim.api.nvim_replace_termcodes(count .. '<C-o>', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  end
end

local function jump_forward()
  close_term_output()
  local count = vim.v.count1
  local keys = vim.api.nvim_replace_termcodes(count .. '<C-i>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

map('n', '<C-o>', jump_backward, { desc = 'Jump backward (closes terminal split)' })
map('n', '<C-l>', jump_forward, { desc = 'Jump forward (closes terminal split)' })
map('n', '<C-i>', jump_forward, { desc = 'Jump forward (closes terminal split)' })

map('n', 'x', '"_x', { desc = 'Delete char to black hole register' })
map('x', 'x', '"_d', { desc = 'Delete selection to black hole register' })
map('n', 'xx', '"_dd', { desc = 'Delete line to black hole register' })

local function open_terminal_prompt(opts)
  opts = opts or {}
  local append_arg = opts.append_arg
  local title = opts.title or ' Run Terminal Command '
  local orig_cmdheight = vim.o.cmdheight
  local orig_showmode = vim.o.showmode
  vim.o.showmode = false
  vim.o.cmdheight = 0

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'

  local width = vim.o.columns
  local height = 1
  -- Position at the bottom row (command line), top border overlays the statusline
  local row = vim.o.lines - 1
  local col = 0

  if #title > (width - 4) then
    title = title:sub(1, math.max(0, width - 7)) .. '... '
  end

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = { '─', '─', '─', '', '', '', '', '' },
    title = title,
    title_pos = 'left',
  })

  vim.wo[win].statuscolumn = '> '

  pcall(function()
    require('cmp').setup.buffer({ enabled = false })
  end)

  local function close()
    vim.cmd('stopinsert')
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    vim.o.cmdheight = orig_cmdheight
    vim.o.showmode = orig_showmode
  end

  local function submit()
    local cmd = vim.trim(vim.api.nvim_get_current_line())
    close()
    if cmd ~= '' then
      if cmd:sub(1, 1) == '>' or cmd:sub(1, 1) == ':' then
        cmd = vim.trim(cmd:sub(2))
      end
      if cmd ~= '' then
        table.insert(term_history, cmd)

        local full_cmd = cmd
        if append_arg and append_arg ~= '' then
          full_cmd = cmd .. ' ' .. vim.fn.shellescape(append_arg)
        end

        if term_win and vim.api.nvim_win_is_valid(term_win) then
          vim.api.nvim_set_current_win(term_win)
        else
          local term_height = math.floor(vim.o.lines * 0.4)
          vim.cmd('botright ' .. term_height .. 'split')
          term_win = vim.api.nvim_get_current_win()
        end

        vim.cmd('term ' .. full_cmd)
        local term_buf = vim.api.nvim_get_current_buf()
        vim.b[term_buf].keep_persistent = true
      end
    end
  end

  local comp_state = nil

  local function trigger_completion(direction)
    local current_line = vim.api.nvim_get_current_line()
    if current_line == '' then
      return
    end

    local is_cycling = comp_state and (current_line == comp_state.prefix .. comp_state.current_text)

    if not is_cycling then
      local prefix, word
      if not current_line:find('%s') then
        prefix = ''
        word = current_line
      else
        prefix, word = current_line:match('^(.*%s)(%S*)$')
        prefix = prefix or ''
        word = word or ''
      end

      local colon_prefix = ''
      if prefix == '' and (word:sub(1, 1) == '>' or word:sub(1, 1) == ':') then
        colon_prefix = word:sub(1, 1)
        word = word:sub(2)
      end

      local matches
      if prefix == '' then
        matches = vim.fn.getcompletion(word, 'shellcmd')
        if #matches == 0 then
          matches = vim.fn.getcompletion(word, 'file')
        end
      else
        matches = vim.fn.getcompletion(word, 'file')
        if #matches == 0 then
          matches = vim.fn.getcompletion(word, 'shellcmd')
        end
      end

      if #matches == 0 then
        comp_state = nil
        return
      end

      comp_state = {
        prefix = prefix .. colon_prefix,
        matches = matches,
        idx = 0,
        current_text = word,
      }
    end

    local count = #comp_state.matches
    if count == 0 then return end

    if direction == 'prev' then
      comp_state.idx = (comp_state.idx - 2 + count) % count + 1
    else
      comp_state.idx = (comp_state.idx % count) + 1
    end

    comp_state.current_text = comp_state.matches[comp_state.idx]
    local new_line = comp_state.prefix .. comp_state.current_text

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { new_line })
    vim.api.nvim_win_set_cursor(win, { 1, math.max(0, #new_line) })
  end

  local history_idx = #term_history + 1
  local function set_line(text)
    comp_state = nil
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })
    vim.api.nvim_win_set_cursor(win, { 1, #text })
  end

  vim.keymap.set({ 'n', 'i' }, '<CR>', submit, { buffer = buf, nowait = true })
  vim.keymap.set({ 'n', 'i' }, '<Esc>', close, { buffer = buf, nowait = true })
  vim.keymap.set({ 'n', 'i' }, '<C-c>', close, { buffer = buf, nowait = true })

  vim.keymap.set({ 'n', 'i' }, '<Tab>', function() trigger_completion('next') end, { buffer = buf, nowait = true })
  vim.keymap.set({ 'n', 'i' }, '<S-Tab>', function() trigger_completion('prev') end, { buffer = buf, nowait = true })
  vim.keymap.set('i', '<C-i>', function() trigger_completion('next') end, { buffer = buf, nowait = true })

  vim.keymap.set({ 'n', 'i' }, '<Up>', function()
    if history_idx > 1 then
      history_idx = history_idx - 1
      set_line(term_history[history_idx])
    end
  end, { buffer = buf, nowait = true })

  vim.keymap.set({ 'n', 'i' }, '<Down>', function()
    if history_idx < #term_history then
      history_idx = history_idx + 1
      set_line(term_history[history_idx])
    elseif history_idx == #term_history then
      history_idx = #term_history + 1
      set_line('')
    end
  end, { buffer = buf, nowait = true })

  vim.cmd('startinsert')
end

_G.open_terminal_prompt = open_terminal_prompt

map('n', 't', function() open_terminal_prompt() end, { desc = 'Run terminal command in popup' })

local function resolve_file(candidate)
  if not candidate or candidate == '' then
    return nil
  end
  local cleaned = candidate:gsub('^[ "\'`<(%[%{]+', ''):gsub('["\'`>)%]%}:,;]+$', '')
  if cleaned == '' then
    return nil
  end

  local function try_path(p)
    if not p or p == '' then
      return nil
    end

    local ok, normalized = pcall(vim.fs.normalize, p)
    local expanded = (ok and normalized) or p

    if expanded:find('%$') then
      expanded = expanded:gsub('%$([%w_]+)', function(var)
        local val = vim.fn.getenv(var)
        return (val ~= vim.NIL and val) or ('$' .. var)
      end)
    end

    local stat = vim.uv.fs_stat(expanded)
    if stat and (stat.type == 'file' or stat.type == 'link') then
      return expanded
    end
    if vim.fn.filereadable(expanded) == 1 then
      return expanded
    end
    local ok_find, found = pcall(vim.fn.findfile, expanded)
    if ok_find and found and found ~= '' then
      return found
    end
    return nil
  end

  local res = try_path(cleaned)
  if res then
    return res
  end

  if cleaned:match('^[ab]/') then
    res = try_path(cleaned:sub(3))
    if res then
      return res
    end
  end

  return nil
end

local function parse_diagnostic_line(line)
  local patterns = {
    -- Python traceback: File "path", line 123
    {
      'File%s+["\']([^"\']+)["\']%s*,%s*line%s+(%d+)',
      function(p, l) return p, tonumber(l), nil end
    },
    -- MSBuild / C#: path(line,col) or path(line)
    {
      '([%w%._%-%/\\]+%.[%w]+)%(%s*(%d+)%s*,?%s*(%d*)%s*%)',
      function(p, l, c) return p, tonumber(l), tonumber(c) end
    },
    -- Cargo / GCC / Clang / Grep: path:line:col
    {
      '([%w%._%-%/\\]+%.[%w]+):(%d+):(%d+)',
      function(p, l, c) return p, tonumber(l), tonumber(c) end
    },
    -- path:line
    {
      '([%w%._%-%/\\]+%.[%w]+):(%d+)',
      function(p, l) return p, tonumber(l), nil end
    },
  }

  local candidates = {}
  for _, item in ipairs(patterns) do
    local pat, fn = item[1], item[2]
    local init = 1
    while true do
      local s, e, p1, p2, p3 = line:find(pat, init)
      if not s then break end
      local p, l, c = fn(p1, p2, p3)
      table.insert(candidates, { path = p, line = l, col = c, start_idx = s, end_idx = e })
      init = e + 1
    end
  end

  for word in line:gmatch('%S+') do
    local cleaned = word:gsub('^[ "\'`<(%[%{]+', ''):gsub('["\'`>)%]%}:,;]+$', '')
    if cleaned ~= '' and not cleaned:match('^[%p%s]+$') then
      table.insert(candidates, { path = cleaned, line = nil, col = nil })
    end
  end

  return candidates
end

local function find_target_file(line, col, cword, cfile)
  local cursor_candidates = {}
  if cword and cword ~= '' then
    local p, l, c = cword:match('^([^:]+):(%d+):?(%d*)')
    if p then
      table.insert(cursor_candidates, { path = p, line = tonumber(l), col = tonumber(c) })
    end
    p, l, c = cword:match('^([^(]+)%((%d+),?(%d*)%)')
    if p then
      table.insert(cursor_candidates, { path = p, line = tonumber(l), col = tonumber(c) })
    end
    table.insert(cursor_candidates, { path = cword, line = nil, col = nil })
  end

  if cfile and cfile ~= '' and cfile ~= cword then
    table.insert(cursor_candidates, { path = cfile, line = nil, col = nil })
  end

  for _, item in ipairs(cursor_candidates) do
    local resolved = resolve_file(item.path)
    if resolved then
      return { path = resolved, line = item.line, col = item.col }
    end
  end

  local line_candidates = parse_diagnostic_line(line)
  local valid = {}
  local first_named_candidate = nil

  for _, item in ipairs(line_candidates) do
    if not first_named_candidate and item.path:find('%.%w+') then
      first_named_candidate = item.path
    end
    local resolved = resolve_file(item.path)
    if resolved then
      local dist = 0
      if col and item.start_idx then
        dist = math.abs(item.start_idx - col)
      end
      table.insert(valid, {
        path = resolved,
        line = item.line,
        col = item.col,
        dist = dist,
      })
    end
  end

  if #valid > 0 then
    table.sort(valid, function(a, b) return a.dist < b.dist end)
    return valid[1]
  end

  return nil, first_named_candidate or cfile or cword
end

local function gf_open(with_line)
  local cur_win = vim.api.nvim_get_current_win()
  local is_term = (cur_win == term_win) or (vim.bo.buftype == 'terminal')

  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local cword = vim.fn.expand('<cWORD>')
  local cfile = vim.fn.expand('<cfile>')

  local target, missing_candidate = find_target_file(line, col, cword, cfile)

  if not target then
    if missing_candidate and missing_candidate ~= '' and missing_candidate ~= '--' then
      vim.notify('File does not exist: ' .. missing_candidate, vim.log.levels.ERROR)
    else
      vim.notify('No file found on current line', vim.log.levels.WARN)
    end
    return
  end

  if is_term then
    close_term_output()
  end

  vim.cmd('edit ' .. vim.fn.fnameescape(target.path))
  if with_line and target.line then
    pcall(vim.api.nvim_win_set_cursor, 0, { target.line, math.max(0, (target.col or 1) - 1) })
    vim.cmd('normal! zz')
  end
end

map('n', 'gf', function() gf_open(true) end, { desc = 'Open file under cursor (closes terminal)' })
map('n', 'gF', function() gf_open(false) end, { desc = 'Open file under cursor (closes terminal)' })

map('x', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('x', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('n', 'J', 'mzJ`z', { desc = 'Join line, keep cursor' })

map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down, center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up, center' })

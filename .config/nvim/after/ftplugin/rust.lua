vim.keymap.set("n", "me", function()
    local clients = vim.lsp.get_clients({ bufnr = 0, name = "rust-analyzer" })
    local client = clients[1]

    if not client then
        vim.notify("rust-analyzer client not found", vim.log.levels.WARN)
        return
    end

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

    client:request("rust-analyzer/expandMacro", params, function(err, result)
        if err or not (result and result.expansion) then
            vim.notify("No macro to expand at cursor", vim.log.levels.WARN)
            return
        end

        -- 1. Format the header block like standard rust-analyzer
        local macro_name = result.name or "macro"
        local title = string.format("// Recursive expansion of the %s macro", macro_name)
        local border = "// " .. string.rep("=", #title - 3)

        local content = {
            border,
            title,
            border,
            "",
        }

        local expansion_lines = vim.split(result.expansion, "\n", { plain = true })
        for _, line in ipairs(expansion_lines) do
            table.insert(content, line)
        end

        -- 2. Find if a dedicated macro expansion buffer already exists
        local buf = nil
        for _, b in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(b) and vim.b[b].is_macro_expansion then
                buf = b
                break
            end
        end

        -- If no buffer exists yet, create a new scratch buffer
        if not buf then
            buf = vim.api.nvim_create_buf(false, true)
            vim.bo[buf].filetype = "rust"
            vim.b[buf].is_macro_expansion = true
            vim.api.nvim_buf_set_name(buf, "[Rust Macro Expansion]")
        end

        -- 3. Check if a window is already displaying this buffer
        local win = vim.fn.bufwinid(buf)

        if win == -1 then
            -- Open a 50/50 vertical split on the right if not open yet
            vim.cmd("rightbelow vsplit")
            vim.cmd("wincmd =")
            win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_buf(win, buf)
        end

        -- 4. Replace the buffer contents with the new expansion
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
    end, 0)
end, { desc = "Expand Rust macro in split" })

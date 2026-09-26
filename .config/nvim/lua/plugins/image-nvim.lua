local function get_backend()
    local term = os.getenv("TERM_PROGRAM") or ""
    if term:lower() == "wezterm" then
        return "sixel"
    end
    return "kitty"
end

return {
    "3rd/image.nvim",
    lazy = false,
    opts = {
        backend = get_backend(),
        processor = "magick_cli",
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = true,
                download_remote_images = true,
                only_render_image_at_cursor = true,
                only_render_image_at_cursor_mode = "inline",
                filetypes = { "markdown", "vimwiki" },
            },
        },
        window_overlap_clear_enabled = true,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
}

local wezterm = require("wezterm")

return {
    -- Allows Ibus Vietnamese
    use_ime = true,
    xim_im_name = "ibus",

    -- Font
    font = wezterm.font("IosevkaTerm Nerd Font Mono", {
      weight = "Medium",
    }),
    font_size = 22.0,

    -- Window size
    initial_cols = 164,
    initial_rows = 25,

    -- Theme
    color_scheme = "Gruber (base16)",

    -- Working directory
    default_cwd = wezterm.home_dir,

    -- Window behavior
    window_close_confirmation = "NeverPrompt",

    -- Optional quality-of-life
    enable_tab_bar = false,
}

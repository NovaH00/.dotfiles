local wezterm = require("wezterm")
local mux = wezterm.mux


local config = wezterm.config_builder()

-- Allows Ibus Vietnamese
config.use_ime = true
config.xim_im_name = "ibus"

-- Font
config.font = wezterm.font("IosevkaTerm Nerd Font Mono", {
  weight = "Medium",
})
config.font_size = 22.0

-- Theme
config.color_scheme = "Gruber (base16)"

-- Window behavior
config.window_close_confirmation = "NeverPrompt"

-- Optional quality-of-life
config.enable_tab_bar = false

config.initial_rows = 100
config.initial_cols = 205

return config

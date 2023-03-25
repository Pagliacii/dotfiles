-- Documentation: https://wezfurlong.org/wezterm/config/files.html
local wezterm = require "wezterm";
local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Colors & Appearance
config.default_cursor_style = "BlinkingBlock"

function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Dracula (Official)" -- "Desert"
    else
        return "Builtin Solarized Light"
    end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
wezterm.on(
    "update-status",
    function(window, pane)
        local overrides = window:get_config_overrides() or {}
        local appearance = wezterm.gui.get_appearance()
        if window:is_focused() then
            overrides.color_scheme = scheme_for_appearance(appearance)
        else
            if appearance:find "Dark" then
                overrides.color_scheme = "Grayscale Dark (base16)"
            else
                overrides.color_scheme =  "Builtin Solarized Dark"
            end
        end
        window:set_config_overrides(overrides)
    end
)

--- Tab Appearance
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

--- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
wezterm.on(
    "format-tab-title",
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = "#0b0022"
        local background = "#1b1032"
        local foreground = "#808080"

        if tab.is_active then
            background = "#2b2042"
            foreground = "#c0c0c0"
        elseif hover then
            background = "#3b3052"
            foreground = "#909090"
        end

        local edge_foreground = background

        -- ensure that the titles fit in the available space,
        -- and that we have room for the edges.
        local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end
)

--- Window Appearance
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.8
config.window_padding = {
    left = "2cell",
    right = "2cell",
    top = "0.5cell",
    bottom = "0.5cell",
}
config.window_frame = {
    border_left_width = "0.25cell",
    border_right_width = "0.25cell",
    border_bottom_height = "0.125cell",
    border_top_height = "0.125cell",
    border_left_color = "skyblue",
    border_right_color = "skyblue",
    border_bottom_color = "skyblue",
    border_top_color = "skyblue",
}
config.adjust_window_size_when_changing_font_size = false

--- Styling inactive panes
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
}

--- Fallback font
config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Fira Code",
})
config.font_size = 16.0
config.line_height = 1.2

--- Disable the scroll bar
config.enable_scroll_bar = false

-- Launching Programs
if string.find(wezterm.target_triple, "pc%-windows") then
    --- Windows specific configurations here
    config.default_prog = {"pwsh.exe", "-NoLogo"}
    config.launch_menu = {{
        label = "pwsh",
        args = config.default_prog,
    }}
end

-- Domains for wezterm connect
config.ssh_domains = {
    {
        -- This name identifies the domain
        name = "manage.pve",
        -- The hostname or address to connect to. Will be used to match settings
        -- from your ssh config file
        remote_address = '192.168.32.2',
        -- The username to use on the remote host
        username = 'root',
    },
}

-- Shortcuts
config.mouse_bindings = {
    -- Right click pastes from the clipboard.
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = act.PasteFrom "Clipboard",
    },

    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.CompleteSelection "ClipboardAndPrimarySelection",
    },

    -- and make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left"} },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
    -- disable the 'Down' event for CRTL-Click to avoid weird program behaviros
    {
        event = { Down = { streak = 1, button = "Left"} },
        mods = "CTRL",
        action = act.Nop,
    },

    -- Scorlling up while holding CTRL increases the font size
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "CTRL",
        action = act.IncreaseFontSize,
    },

    -- Scorlling down while holding CTRL decreases the font size
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "CTRL",
        action = act.DecreaseFontSize,
    },
}
config.keys = {
    -- Splits the active pane in a particular direction.
    {
        key = "\\",
        mods = "CTRL",
        action = act.SplitPane {
            direction = "Down",
            size = { Percent = 50 },
        },
    },
    {
        key = "\\",
        mods = "CTRL|ALT",
        action = act.SplitPane {
            direction = "Up",
            size = { Percent = 50 },
        },
    },
    {
        key = "[",
        mods = "CTRL",
        action = act.SplitPane {
            direction = "Right",
            size = { Percent = 50 },
        },
    },
    {
        key = "[",
        mods = "CTRL|ALT",
        action = act.SplitPane {
            direction = "Left",
            size = { Percent = 50 },
        },
    },
    -- Closes the current pane.
    {
        key = "q",
        mods = "CTRL",
        action = act.CloseCurrentPane {
            confirm = false,
        },
    },
    -- Activates the pane selection modal display.
    {
        key = ";",
        mods = "CTRL",
        action = act.PaneSelect {
            alphabet = "0123456789",
        },
    },
    {
        key = "'",
        mods = "CTRL",
        action = act.PaneSelect {
            alphabet = "0123456789",
            mode = "SwapWithActive",
        },
    },
    -- Rotates the sequence of panes within the active tab,
    -- preserving the sizes based on the tab positions.
    {
        key = ",",
        mods = "CTRL|ALT",
        action = act.RotatePanes "CounterClockwise",
    },
    {
        key = ".",
        mods = "CTRL|ALT",
        action = act.RotatePanes "Clockwise",
    },
    -- Adjusts the scroll position by the number of lines specified by the argument.
    -- Negative values scroll upwards, while positive values scroll downwards.
    {
        key = "j",
        mods = "CTRL",
        action = act.ScrollByLine(1),
    },
    {
        key = "k",
        mods = "CTRL",
        action = act.ScrollByLine(-1),
    },
    -- Toggles the zoom state of the current pane.
    {
        key = "Z",
        mods = "CTRL",
        action = act.TogglePaneZoomState,
    },
    -- Activate the Launcher Menu in the current tab.
    {
        key = "l",
        mods = "ALT",
        action = act.ShowLauncher,
    },
    -- Activate the tab navigator UI in the current tab.
    {
        key = "t",
        mods = "ALT",
        action = act.ShowTabNavigator,
    },
}

--- Visual bell
config.visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor",
}
config.audible_bell = "Disabled"

wezterm.on(
    "window-config-reloaded",
    function(window, pane)
        window:toast_notification("wezterm", "configuration reloaded!", nil, 1000)
    end
)
wezterm.on(
    "gui-startup",
    function(configs)
        -- local tab, pane, window = mux.spawn_window(
        local default_configs = {
            width = 286,
            height = 58,
            position = {
                x = 20,
                y = 20,
                origin = "ActiveScreen",
            },
        }
        mux.spawn_window(configs or default_configs)
        -- local current_window = window:gui_window()
        -- current_window:maximize()
        -- local dimensions = current_window:get_dimensions()
        -- wezterm.log_error(dimensions.pixel_width, dimensions.pixel_height)
        -- local current_configs = current_window:effective_config()
        -- wezterm.log_error(current_configs.initial_cols, current_configs.initial_rows)
        -- local col_ratio = dimensions.pixel_width // current_configs.initial_cols
        -- local row_ratio = dimensions.pixel_height // current_configs.initial_rows
        -- local col_ratio = 20
        -- local row_ratio = 55

        -- local overrides = current_window:get_config_overrides() or {}
        -- overrides.initial_cols = dimensions.pixel_width // col_ratio - 4
        -- overrides.initial_rows = dimensions.pixel_height // row_ratio - 4
        -- current_window:set_config_overrides(overrides)
        -- current_window:restore()
        -- current_window:set_inner_size(3800, 2000)
        -- current_window:set_position(20, 20)
        -- current_window:restore()
    end
)

return config

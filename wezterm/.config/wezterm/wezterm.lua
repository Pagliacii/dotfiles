-- Documentation: https://wezfurlong.org/wezterm/config/files.html
local wezterm = require("wezterm")
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

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

--- Tab Appearance
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.colors = {
	tab_bar = {
		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#11111b",
			fg_color = "#cdd6f4",
		},
		new_tab_hover = {
			bg_color = "#99ccff",
			fg_color = "#0c0c0c",
			italic = false,
		},
	},
	-- the foreground color of selected text
	selection_fg = "black",
	-- the background color of selected text
	selection_bg = "#fffacd",
}

--- Window Appearance
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.8
config.text_background_opacity = 0.8
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

--- Fallback font
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
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
	config.enable_tab_bar = true
	config.tab_bar_at_bottom = true

	config.default_prog = { "pwsh.exe", "-NoLogo" }
	config.launch_menu = { {
		label = "pwsh",
		args = config.default_prog,
	} }

	wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
		--- The filled in variant of the < symbol
		local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
		--- The filled in variant of the > symbol
		local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

		local edge_background = "#11111b"
		local background = "#0044cc"
		local foreground = "#808080"

		if tab.is_active then
			background = "#4d88ff"
			foreground = "#f0f0f0"
		elseif hover then
			background = "#1a66ff"
			foreground = "#c0c0c0"
		end

		local edge_foreground = background

		-- ensure that the titles fit in the available space,
		-- and that we have room for the edges.
		-- local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)
		local title = tab.active_pane.title:gsub("%.exe", "")
		title = title:match("[^\\]+$") -- extract the last part of path
		title = wezterm.truncate_right(string.format("%d:%s", tab.tab_id, title), max_width - 2)

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
	end)

	wezterm.on("gui-startup", function(cmd)
		-- allow `wezterm start -- something` to affect what we spawn
		-- in our initial window
		local args = config.default_prog
		if cmd then
			args = cmd.args
		end

		-- Set a workspace for coding
		mux.spawn_window({
			width = 286,
			height = 57,
			position = {
				x = 20,
				y = 20,
				origin = "ActiveScreen",
			},
			workspace = "coding",
			-- cwd = "path/to/your/project",
			args = args,
		})

		--[[
		-- Split 4 panes
		local top_pane = pane:split({
			direction = "Top",
			size = 0.5,
			-- cwd = "path/to/your/project",
		})
		pane:split({
			direction = "Left",
			size = 0.5,
			-- cwd = "path/to/your/project",
		})
		top_pane:split({
			direction = "Left",
			size = 0.5,
			-- cwd = "path/to/your/project",
		})
    --]]
		-- We want to startup in the coding workspace
		mux.set_active_workspace("coding")
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
	end)

	wezterm.on("update-right-status", function(window, pane)
		-- Each element holds the text for a cell in a "powerline" style << fade
		local cells = {}

		-- Figure out the cwd and host of the current pane.
		-- This will pick up the hostname for the remote host if your
		-- shell is using OSC 7 on the remote host.
		local cwd_uri = pane:get_current_working_dir()
		if cwd_uri then
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			local cwd = ""
			local hostname = ""
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- Remove the domain name portion of the hostname
				local dot = hostname:find("[.]")
				if dot then
					hostname = hostname:sub(1, dot - 1)
				end
				-- and extract the cwd from the uri
				cwd = cwd_uri:sub(slash)
				if cwd:find("[:]") and cwd:sub(1, 1) == "/" then
					cwd = cwd:sub(2, #cwd)
				end

				cwd = string.gsub(cwd, "/", "\\")
				table.insert(cells, cwd)
				if hostname ~= "" then
					table.insert(cells, hostname)
				end
			end
		end

		-- I like my date/time in this style: "Wed Mar 3 08:14:25"
		local date = wezterm.strftime("%a %b %-d %H:%M:%S")
		table.insert(cells, date)

		-- An entry for each battery (typically 0 or 1 battery)
		for _, b in ipairs(wezterm.battery_info()) do
			table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
		end

		-- The filled in variant of the < symbol
		local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

		-- Color palette for the backgrounds of each cell
		local colors = {
			"#80aaff",
			"#6699ff",
			"#4d88ff",
			"#3377ff",
			"#1a66ff",
		}

		-- Foreground color for the text across the fade
		local text_fg = "#e0e0e0"

		-- The elements to be formatted
		local elements = {}
		-- How many cells have been formatted
		local num_cells = 0

		-- Translate a cell into elements
		local function push(text, is_last)
			if num_cells == 0 then
				table.insert(elements, { Foreground = { Color = colors[1] } })
				table.insert(elements, { Text = SOLID_LEFT_ARROW })
			end
			local cell_no = num_cells + 1
			table.insert(elements, { Foreground = { Color = text_fg } })
			table.insert(elements, { Background = { Color = colors[cell_no] } })
			table.insert(elements, { Text = " " .. text .. " " })
			if not is_last then
				table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
				table.insert(elements, { Text = SOLID_LEFT_ARROW })
			end
			num_cells = num_cells + 1
		end

		while #cells > 0 do
			local cell = table.remove(cells, 1)
			push(cell, #cells == 0)
		end

		window:set_right_status(wezterm.format(elements))
	end)
end

-- Domains for wezterm connect
config.ssh_domains = {
	{
		-- This name identifies the domain
		name = "pve",
		-- The hostname or address to connect to. Will be used to match settings
		-- from your ssh config file
		remote_address = "192.168.32.2",
		-- The username to use on the remote host
		username = "root",
	},
}

-- Shortcuts
config.mouse_bindings = {
	-- Right click pastes from the clipboard.
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},

	-- Change the default click behavior so that it only selects
	-- text and doesn"t open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},

	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	-- disable the "Down" event for CRTL-Click to avoid weird program behaviros
	{
		event = { Down = { streak = 1, button = "Left" } },
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

--[[ smart-splits.nvim integrations
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end
local direction_keys = {
	Left = "h",
	Right = "l",
	Up = "k",
	Down = "j",
	-- reverse lookup
	h = "Left",
	l = "Right",
	k = "Up",
	j = "Down",
}
local function split_nav(resize_or_move, key)
	local resize = resize_or_move == "resize"
	local mod_key = resize and "META|SHIFT" or "CTRL"
	return {
		key = key,
		mods = mod_key,
		action = wezterm.action_callback(function(win, pane)
			print(is_vim(pane))
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = mod_key },
				}, pane)
			else
				if resize then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end
--]]
config.keys = {
	-- Splits the active pane in a particular direction.
	{
		key = "-",
		mods = "CTRL|ALT",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "\\",
		mods = "CTRL|ALT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	-- Closes the current pane.
	{
		key = "Q",
		mods = "ALT",
		action = act.CloseCurrentPane({
			confirm = false,
		}),
	},
	-- Activates the pane selection modal display.
	{
		key = ";",
		mods = "CTRL",
		action = act.PaneSelect({
			alphabet = "0123456789",
		}),
	},
	{
		key = "'",
		mods = "CTRL",
		action = act.PaneSelect({
			alphabet = "0123456789",
			mode = "SwapWithActive",
		}),
	},
	-- Activate an adjacent pane in the specified direction.
	{
		key = "H",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "J",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "K",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	-- move between split panes
	-- split_nav("move", "h"),
	-- split_nav("move", "j"),
	-- split_nav("move", "k"),
	-- split_nav("move", "l"),
	-- -- resize panes
	-- split_nav("resize", "h"),
	-- split_nav("resize", "j"),
	-- split_nav("resize", "k"),
	-- split_nav("resize", "l"),
	-- Rotates the sequence of panes within the active tab,
	-- preserving the sizes based on the tab positions.
	{
		key = ",",
		mods = "CTRL|ALT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{
		key = ".",
		mods = "CTRL|ALT",
		action = act.RotatePanes("Clockwise"),
	},
	-- Activate a tab relative to the current tab.
	{
		key = "[",
		mods = "ALT",
		action = act.ActivateTabRelative(-1), -- left
	},
	{
		key = "]",
		mods = "ALT",
		action = act.ActivateTabRelative(1), -- right
	},
	-- Toggles the zoom state of the current pane.
	{
		key = "Z",
		mods = "CTRL",
		action = act.TogglePaneZoomState,
	},
	-- Activate the Launcher Menu in the current tab.
	{
		key = "1",
		mods = "ALT",
		action = act.ShowLauncher,
	},
	-- Activate the tab navigator UI in the current tab.
	{
		key = "2",
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

--- Integration with NeoVim Zen Mode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config

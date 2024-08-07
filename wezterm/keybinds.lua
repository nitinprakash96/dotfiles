local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
M.tmux_keybinds = {
	{ key = "k", mods = "OPT",      action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "OPT",      action = act({ CloseCurrentTab = { confirm = true } }) },
	{ key = "h", mods = "OPT",      action = act({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "OPT",      action = act({ ActivateTabRelative = 1 }) },
	{ key = "h", mods = "OPT|CTRL", action = act({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "OPT|CTRL", action = act({ MoveTabRelative = 1 }) },
	--{ key = "k", mods = "OPT|CTRL", action = act.ActivateCopyMode },
	{
		key = "k",
		mods = "OPT|CTRL",
		action = act.Multiple({ act.CopyMode("ClearSelectionMode"), act.ActivateCopyMode, act.ClearSelection }),
	},
	{ key = "j",     mods = "OPT|CTRL",       action = act({ PasteFrom = "PrimarySelection" }) },
	{ key = "1",     mods = "OPT",            action = act({ ActivateTab = 0 }) },
	{ key = "2",     mods = "OPT",            action = act({ ActivateTab = 1 }) },
	{ key = "3",     mods = "OPT",            action = act({ ActivateTab = 2 }) },
	{ key = "4",     mods = "OPT",            action = act({ ActivateTab = 3 }) },
	{ key = "5",     mods = "OPT",            action = act({ ActivateTab = 4 }) },
	{ key = "6",     mods = "OPT",            action = act({ ActivateTab = 5 }) },
	{ key = "7",     mods = "OPT",            action = act({ ActivateTab = 6 }) },
	{ key = "8",     mods = "OPT",            action = act({ ActivateTab = 7 }) },
	{ key = "9",     mods = "OPT",            action = act({ ActivateTab = 8 }) },
	{ key = "-",     mods = "OPT",            action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\",    mods = "OPT",            action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "l",     mods = "OPT|SHIFT",      action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "h",     mods = "OPT|SHIFT",      action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "k",     mods = "OPT|SHIFT",      action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "j",     mods = "OPT|SHIFT",      action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "h",     mods = "OPT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l",     mods = "OPT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k",     mods = "OPT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j",     mods = "OPT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = "Enter", mods = "OPT",            action = "QuickSelect" },
	{ key = "/",     mods = "OPT",            action = act.Search("CurrentSelectionOrEmptyString") },
}

M.default_keybinds = {
	{ key = "c",          mods = "CMD",       action = act({ CopyTo = "Clipboard" }) },
	{ key = "v",          mods = "CMD",       action = act({ PasteFrom = "Clipboard" }) },
	{ key = "Insert",     mods = "SHIFT",     action = act({ PasteFrom = "PrimarySelection" }) },
	{ key = "=",          mods = "CTRL",      action = "ResetFontSize" },
	{ key = "+",          mods = "CMD",       action = "IncreaseFontSize" },
	{ key = "-",          mods = "CTRL",      action = "DecreaseFontSize" },
	{ key = "PageUp",     mods = "OPT",       action = act({ ScrollByPage = -1 }) },
	{ key = "PageDown",   mods = "OPT",       action = act({ ScrollByPage = 1 }) },
	{ key = "b",          mods = "OPT",       action = act({ ScrollByPage = -1 }) },
	{ key = "f",          mods = "OPT",       action = act({ ScrollByPage = 1 }) },
	{ key = "z",          mods = "OPT",       action = "ReloadConfiguration" },
	{ key = "z",          mods = "OPT|SHIFT", action = act({ EmitEvent = "toggle-tmux-keybinds" }) },
	{ key = "e",          mods = "OPT",       action = act({ EmitEvent = "trigger-nvim-with-scrollback" }) },
	{ key = "d",          mods = "CTRL",      action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "a",          mods = "OPT",       action = wezterm.action.ShowLauncher },
	{ key = " ",          mods = "OPT",       action = wezterm.action.ShowTabNavigator },
	{ key = "d",          mods = "OPT|SHIFT", action = wezterm.action.ShowDebugOverlay },
    { key = "LeftArrow",  mods = "OPT",       action = wezterm.action{ SendString = "\x1bb" }}, -- backword-word
    { key = "RightArrow", mods = "OPT",       action = wezterm.action{ SendString = "\x1bf" }}, -- forward-word
	{ key = 'LeftArrow',  mods = 'CMD',       action = wezterm.action.SendKey({ key = 'a', mods = 'CTRL' }) }, -- jump to start of a line
	{ key = 'RightArrow', mods = 'CMD',       action = wezterm.action.SendKey({ key = 'e', mods = 'CTRL' }) }, -- jump to end of a line
	{ key = "[",          mods = "CMD|SHIFT", action = act({ ActivateTabRelative = -1 }) },     -- Jump to left pane
	{ key = "]",          mods = "CMD|SHIFT", action = act({ ActivateTabRelative = 1 }) },      -- Jump to right pane
	{ key = "Backspace",  mods = "CMD",       action = act { SendString = "\x15" } },           -- delete entire line
  	{ key = "Backspace",  mods = "OPT",       action = act { SendString = "\x17" } },           -- Delete entire word
	{ key = 'd',          mods = 'CMD',       action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  	{ key = 'd',          mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }},
	{ key = 't',          mods = 'CMD',       action = act.SpawnTab 'CurrentPaneDomain' }, -- create a new tab
	{
		key = "r",
		mods = "OPT",
		action = act({
			ActivateKeyTable = {
				name = "resize_pane",
				one_shot = false,
				timeout_milliseconds = 3000,
				replace_current = false,
			},
		}),
	},
	{
		key = "s",
		mods = "OPT",
		action = act.PaneSelect({
			alphabet = "1234567890",
		})
	},
	{
		key = "`",
		mods = "OPT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "`", mods = "OPT|SHIFT", action = act.RotatePanes("Clockwise") },
	{
		key = "E",
		mods = "OPT|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			-- selene: allow(unused_variable)
			---@diagnostic disable-next-line: unused-local
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

function M.create_keybinds()
	return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

M.key_tables = {
	resize_pane = {
		{ key = "LeftArrow",  action = act({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "h",          action = act({ AdjustPaneSize = { "Left", 1 } }) },
		{ key = "RightArrow", action = act({ AdjustPaneSize = { "Right", 1 } }) },
		{ key = "l",          action = act({ AdjustPaneSize = { "Right", 1 } }) },
		{ key = "UpArrow",    action = act({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "k",          action = act({ AdjustPaneSize = { "Up", 1 } }) },
		{ key = "DownArrow",  action = act({ AdjustPaneSize = { "Down", 1 } }) },
		{ key = "j",          action = act({ AdjustPaneSize = { "Down", 1 } }) },
		-- Cancel the mode by pressing escape
		{ key = "Escape",     action = "PopKeyTable" },
	},
	copy_mode = {
		{
			key = "Escape",
			mods = "NONE",
			action = act.Multiple({
				act.ClearSelection,
				act.CopyMode("ClearPattern"),
				act.CopyMode("Close"),
			}),
		},
		{ key = "q",          mods = "NONE",  action = act.CopyMode("Close") },
		-- move cursor
		{ key = "h",          mods = "NONE",  action = act.CopyMode("MoveLeft") },
		{ key = "LeftArrow",  mods = "NONE",  action = act.CopyMode("MoveLeft") },
		{ key = "j",          mods = "NONE",  action = act.CopyMode("MoveDown") },
		{ key = "DownArrow",  mods = "NONE",  action = act.CopyMode("MoveDown") },
		{ key = "k",          mods = "NONE",  action = act.CopyMode("MoveUp") },
		{ key = "UpArrow",    mods = "NONE",  action = act.CopyMode("MoveUp") },
		{ key = "l",          mods = "NONE",  action = act.CopyMode("MoveRight") },
		{ key = "RightArrow", mods = "NONE",  action = act.CopyMode("MoveRight") },
		-- move word
		{ key = "RightArrow", mods = "OPT",   action = act.CopyMode("MoveForwardWord") },
		{ key = "f",          mods = "OPT",   action = act.CopyMode("MoveForwardWord") },
		{ key = "\t",         mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
		{ key = "w",          mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
		{ key = "LeftArrow",  mods = "OPT",   action = act.CopyMode("MoveBackwardWord") },
		{ key = "b",          mods = "OPT",   action = act.CopyMode("MoveBackwardWord") },
		{ key = "\t",         mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
		{ key = "b",          mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },
		{
			key = "e",
			mods = "NONE",
			action = act({
				Multiple = {
					act.CopyMode("MoveRight"),
					act.CopyMode("MoveForwardWord"),
					act.CopyMode("MoveLeft"),
				},
			}),
		},
		-- move start/end
		{ key = "0",  mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
		{ key = "\n", mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },
		{ key = "$",  mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "$",  mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "e",  mods = "CTRL",  action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "m",  mods = "OPT",   action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^",  mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "^",  mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "a",  mods = "CTRL",  action = act.CopyMode("MoveToStartOfLineContent") },
		-- select
		{ key = " ",  mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v",  mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{
			key = "v",
			mods = "SHIFT",
			action = act({
				Multiple = {
					act.CopyMode("MoveToStartOfLineContent"),
					act.CopyMode({ SetSelectionMode = "Cell" }),
					act.CopyMode("MoveToEndOfLineContent"),
				},
			}),
		},
		-- copy
		{
			key = "y",
			mods = "NONE",
			action = act({
				Multiple = {
					act({ CopyTo = "ClipboardAndPrimarySelection" }),
					act.CopyMode("Close"),
				},
			}),
		},
		{
			key = "y",
			mods = "SHIFT",
			action = act({
				Multiple = {
					act.CopyMode({ SetSelectionMode = "Cell" }),
					act.CopyMode("MoveToEndOfLineContent"),
					act({ CopyTo = "ClipboardAndPrimarySelection" }),
					act.CopyMode("Close"),
				},
			}),
		},
		-- scroll
		{ key = "G",        mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "G",        mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "g",        mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "H",        mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
		{ key = "H",        mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
		{ key = "M",        mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "M",        mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "L",        mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
		{ key = "L",        mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "o",        mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "O",        mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "O",        mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "PageUp",   mods = "NONE",  action = act.CopyMode("PageUp") },
		{ key = "PageDown", mods = "NONE",  action = act.CopyMode("PageDown") },
		{ key = "b",        mods = "CTRL",  action = act.CopyMode("PageUp") },
		{ key = "f",        mods = "CTRL",  action = act.CopyMode("PageDown") },
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("ClearSelectionMode"),
		},
		-- search
		{ key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
		{
			key = "n",
			mods = "NONE",
			action = act.Multiple({
				act.CopyMode("NextMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
		{
			key = "N",
			mods = "SHIFT",
			action = act.Multiple({
				act.CopyMode("PriorMatch"),
				act.CopyMode("ClearSelectionMode"),
			}),
		},
	},
	search_mode = {
		{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
		{
			key = "Enter",
			mods = "NONE",
			action = act.Multiple({
				act.CopyMode("ClearSelectionMode"),
				act.ActivateCopyMode,
			}),
		},
		{ key = "p",      mods = "CTRL", action = act.CopyMode("PriorMatch") },
		{ key = "n",      mods = "CTRL", action = act.CopyMode("NextMatch") },
		{ key = "r",      mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "/",      mods = "NONE", action = act.CopyMode("ClearPattern") },
		{ key = "u",      mods = "CTRL", action = act.CopyMode("ClearPattern") },
	},
}

M.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act({ CompleteSelection = "PrimarySelection" }),
	},
	{
		event = { Up = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act({ CompleteSelection = "Clipboard" }),
	},
	-- Disable the 'Down' event of Cmd-Click to avoid weird program behaviors
	{
		event = { Down = { streak = 1, button = 'Left' } },
		mods = 'CMD',
		action = act.Nop,
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = "OpenLinkAtMouseCursor",
	},
	-- {
	-- 	event = { Up = { streak = 1, button = 'Middle' } },
	-- 	mods = 'NONE',
	-- 	action = act({ PasteFrom = "PrimarySelection" })
	-- },
	-- {
	-- 	event = { Down = { streak = 1, button = 'Middle' } },
	-- 	mods = 'NONE',
	-- 	action = act.DisableDefaultAssignment
	-- },
}

return M

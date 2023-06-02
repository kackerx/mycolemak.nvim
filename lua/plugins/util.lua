return {
	{ "nacro90/numb.nvim",    event = "BufReadPre", config = true, enabled = true },
	{ "nvim-lua/plenary.nvim" },
	{ "kkharji/sqlite.lua" },
	{
		"folke/persistence.nvim",
		enabled = true,
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
		-- stylua: ignorest
		keys = {
			{ "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
			{
				"<leader>qd",
				function() require("persistence").stop() end,
				desc =
				"Don't Save Current Session"
			},
		},
	},
	-- { "tpope/vim-repeat", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end
	},
	{
		"windwp/nvim-autopairs",
		enabled = true,
		event = "VeryLazy",
		config = function()
			-- local npairs = require('nvim-autopairs')

			-- 在行末输入 ({[ 时自动补全右括号并且将光标移动到输入位置
			-- local Rule = require('nvim-autopairs.rule')
			-- npairs.add_rules({
			-- 	Rule("%(.*%)%s%->%s$", "->", " -> ", { "c" }),
			-- 	Rule("%(.*%)%s:%s$", ":", " : ", { "c" }),
			-- 	Rule("%(.*%)%s,%s$", ",", ", ", { "c" }),
			-- 	Rule("%(.*%)%s;%s$", ";", "; ", { "c" }),
			-- 	Rule("%(.*%)%s=%s$", "=", " = ", { "c" }),
			-- 	Rule("%(.*%)%s[%+%-%*/%%%^~|&<>!=]=%s$", "", " ${1}= ", { "c" }),
			-- 	Rule("%(.*%)%s[%+%-%*/%%%^~|&<>!]=%s$", "", " ${1}= ", { "c" }),
			-- 	Rule("%(.*%)%s[%+%-%*/%%%^~|&<>]=%s$", "", " ${1}${1}= ", { "c" }),
			-- 	Rule("%(.*%)%s[%+%-%*/%%%^~|&<>]$", "", " ${1}${1}", { "c" }),
			-- 	Rule("%(.*%)%s[({%[%<]$", "", ")${1}", { "c", "r", "t" }),
			-- })

			-- 启用自动补全
			-- npairs.enable()
			require("nvim-autopairs").setup {}
		end
	},
	{
		'phaazon/hop.nvim',
		enabled = true,
		cmd = "HopWord",
		config = function(_, _)
			require("hop").setup()
		end
	},
	{
		"Xuyuanp/scrollbar.nvim",
		enabled = true,
		event = "VeryLazy"
	},
	-- {
	-- 	'keaising/im-select.nvim',
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require('im_select').setup {
	--
	-- 			-- IM will be set to `default_im_select` in `normal` mode
	-- 			-- For Windows/WSL, default: "1033", aka: English US Keyboard
	-- 			-- For macOS, default: "com.apple.keylayout.ABC", aka: US
	-- 			-- For Linux, default: "keyboard-us"
	-- 			-- You can use `im-select` or `fcitx5-remote -n` to get the IM's name you preferred
	-- 			default_im_select       = "com.apple.keylayout.Colemak",
	--
	-- 			-- Can be binary's name or binary's full path,
	-- 			-- e.g. 'im-select' or '/usr/local/bin/im-select'
	-- 			-- For Windows/WSL, default: "im-select.exe"
	-- 			-- For macOS, default: "im-select"
	-- 			-- For Linux, default: "fcitx5-remote"
	-- 			default_command         = 'im-select',
	--
	-- 			-- Restore the default input method state when the following events are triggered
	-- 			set_default_events      = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
	--
	-- 			-- Restore the previous used input method state when the following events are triggered
	-- 			-- if you don't want to restore previous used im in Insert mode,
	-- 			-- e.g. deprecated `disable_auto_restore = 1`, just let it empty `set_previous_events = {}`
	-- 			set_previous_events     = { "InsertEnter" },
	--
	-- 			-- Show notification about how to install executable binary when binary is missing
	-- 			keep_quiet_on_no_binary = false
	-- 		}
	-- 	end
	-- },
	{
		"michaelb/sniprun",
		-- run = 'bash install.sh', -- 运行安装脚本
		-- cmd = 'SnipRun', -- 当执行SnipRun命令时懒加载
		ft = { 'python', 'lua', 'go' }, -- 当文件类型是python或lua时懒加载
		config = function()
			require("sniprun").setup {
				selected_interpreters = {}, --# use those instead of the default for the current filetype
				repl_enable = {}, --# enable REPL-like behavior for the given interpreters
				repl_disable = {}, --# disable REPL-like behavior for the given interpreters

				interpreter_options = {
					--# intepreter-specific options, see docs / :SnipInfo <name>
					GFM_original = {
						use_on_filetypes = { "markdown.pandoc" } --# the 'use_on_filetypes' configuration key is
						--# available for every interpreter
					}
				},

				--# you can combo different display modes as desired
				display = {
					"Classic", --# display results in the command-line  area
					"VirtualTextOk", --# display ok results as virtual text (multiline is shortened)

					-- "VirtualTextErr",          --# display error results as virtual text
					-- "TempFloatingWindow",      --# display results in a floating window
					-- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
					"Terminal", --# display results in a vertical split
					-- "TerminalWithCode",        --# display results and code history in a vertical split
					-- "NvimNotify",              --# display with the nvim-notify plugin
					-- "Api"                      --# return output to a programming interface
				},

				display_options = {
					terminal_width = 45, --# change the terminal display option width
					notification_timeout = 5 --# timeout for nvim_notify output
				},

				--# You can use the same keys to customize whether a sniprun producing
				--# no output should display nothing or '(no output)'
				show_no_output = {
					"Classic",
					"TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
				},

				--# customize highlight groups (setting this overrides colorscheme)
				snipruncolors = {
					SniprunVirtualTextOk  = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
					SniprunFloatingWinOk  = { fg = "#66eeff", ctermfg = "Cyan" },
					SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
					SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
				},

				--# miscellaneous compatibility/adjustement settings
				inline_messages = 0, --# inline_message (0/1) is a one-line way to display messages
				--# to workaround sniprun not being able to display anything

				borders = 'single', --# display borders around floating windows
				--# possible values are 'none', 'single', 'double', or 'shadow'
				live_mode_toggle = 'off' --# live mode toggle, see Usage - Running for more info
			}
		end
	}
}

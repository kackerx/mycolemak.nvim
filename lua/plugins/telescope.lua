local Util = require("util")

return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = true,
		-- cmd = "Telescope", -- 按命令时才加载插件, 非启动加载
		event = "BufReadPre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"BurntSushi/ripgrep",
			-- "nvim-telescope/telescope-file-browser.nvim",
			"smartpde/telescope-recent-files",
			"gbrlsnchs/telescope-lsp-handlers.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"tsakirist/telescope-lazy.nvim",
		},
		keys = {
			-- short
			{ "<leader>,",   Util.tele_builtin("buffers", { show_all_buffers = true }), desc = "Switch Buffer" },
			{ "<leader>/",   Util.tele_builtin("live_grep"),                            desc = "Find in Files (Grep)" },
			{ "<leader>:",   Util.tele_builtin("command_history"),                      desc = "Command History" },
			{ "<leader>ff",  Util.tele_builtin("find_files"),                           desc = "Find Files (root dir)" },
			-- { "<C-m>", Util.tele_builtin("oldfiles"), desc = "Find Files (root dir)" },
			{ "<leader>fq",  Util.tele_builtin("quickfix"),                             desc = "Find Files (root dir)" },
			{ "<leader>fj",  Util.tele_builtin("jumplist"),                             desc = "Find Files (root dir)" },
			-- git
			{ "<leader>fgc", Util.tele_builtin("git_commits"),                          desc = "commits" },
			{ "<leader>fgs", Util.tele_builtin("git_status"),                           desc = "status" },
			-- find
			{ "<leader>fb",  Util.tele_builtin("buffers"),                              desc = "Buffers" },
			-- { "<leader>fr",      Util.tele_extn("frecency"),                                desc = "Recent" },
			-- { "<leader>e", Util.tele_extn("file_browser", { path = "%:p:h" }), desc = "File Browser" },
			-- { "<leader>E", Util.tele_extn("file_browser"), desc = "File Browser" },
			{ "<leader>E",   Util.tele_extn("recent_files"),                            desc = "File Browser" },
			{ "<leader>fa",  Util.tele_builtin("autocommands"),                         desc = "Auto Commands" },
			{ "<leader>fc",  Util.tele_builtin("commands"),                             desc = "Commands" },
			{ "<leader>fd",  Util.tele_builtin("diagnostics"),                          desc = "Diagnostics" },
			{ "<leader>fh",  Util.tele_builtin("help_tags"),                            desc = "Help Pages" },
			{ "<leader>fH",  Util.tele_builtin("highlights"),                           desc = "Search Highlight Groups" },
			{ "<leader>fk",  Util.tele_builtin("keymaps"),                              desc = "Key Maps" },
			{ "<leader>fK",  Util.tele_builtin("search_history"),                       desc = "Key Maps" },
			{ "<leader>fm",  Util.tele_builtin("marks"),                                desc = "Jump to Mark" },
			{ "<leader>fo",  Util.tele_builtin("vim_options"),                          desc = "Options" },
			{ "<leader>fl",  Util.tele_extn("lazy"),                                    desc = "Lazy" },
			{
				"<leader>uc",
				Util.tele_builtin("colorscheme", { enable_preview = true }),
				desc = "Colorscheme with preview",
			},
			{
				"<leader>fs",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>fS",
				Util.telescope("lsp_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		},
		config = function(_, _)
			-- local fb_actions = require("telescope._extensions.file_browser.actions")
			local actions = require "telescope.actions"

			local opts = {
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					file_ignore_patterns = { "%.jpeg$", "%.jpg$", "%.png$", ".DS_Store", "%.aux" },
					prompt_position = "top", -- no
				},
				layout_config = {
					width = 0.75,
					height = 0.75,
					prompt_position = "top",
					horizontal = {
						preview_width = function(_, cols, _)
							if cols > 200 then
								return math.floor(cols * 0.4)
							else
								return math.floor(cols * 0.6)
							end
						end,
					},
					vertical = {
						preview_height = 0.5,
					},
				},
				mappings = {
					i = {
						["<Esc>"] = actions.close, -- 退出telescope窗口
					},
					i = {
						["<C-k>"] = actions.select_vertical,
					},
					n = {
						["<C-k>"] = actions.select_vertical,
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
						find_command = { "fd" },
					}
				},
				extensions = {
					-- frecency = {
					-- 	show_scores = true,
					-- 	workspaces = {
					-- 		["conf"] = vim.fn.expand("~") .. "/.config",
					-- 		["doc"] = vim.fn.expand("~") .. "/Documents",
					-- 		["cor"] = vim.fn.expand("~") .. "/Documents/Courses",
					-- 	},
					-- },
					["ui-select"] = {
						require("telescope.themes").get_dropdown {
							-- even more opts
						}
					},
					recent_files = {
						-- This extension's options, see below.
					},
					aerial = {
						-- Display symbols as <root>.<parent>.<symbol>
						show_nesting = {
							['_'] = false, -- This key will be the default
							json = true, -- You can set the option for specific filetypes
							yaml = true,
						}
					},
					lsp_handlers = {
						code_action = {
							telescope = require('telescope.themes').get_cursor({}),
						},
					},
				},

			}
			local telescope = require("telescope")
			telescope.setup(opts)

			local extns = { "fzf", "lazy", "ui-select", "recent_files", "aerial", "lsp_handlers" }
			for _, extn in ipairs(extns) do
				telescope.load_extension(extn)
			end
		end,
	}, 
	{
		'edolphin-ydf/goimpl.nvim',
		dependencies  = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-telescope/telescope.nvim'},
			{'nvim-treesitter/nvim-treesitter'},
		},
		config = function()
			require'telescope'.load_extension'goimpl'
		end,
	}
}

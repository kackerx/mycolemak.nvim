return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		-- dependencies = {
		-- 	"rafamadriz/friendly-snippets",
		-- 	config = function()
		-- 		require("luasnip.loaders.from_vscode").lazy_load()
		-- 	end,
		-- },
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		config = function()
			require("luasnip").config.set_config({
				enable_autosnippets = true,
				store_selection_keys = "`",
			})
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/luasnip" })
		end,
		keys = {
			{
				"<Tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next"
						or "<c-\\><c-n>:call searchpair('[([{<|]', '', '[)\\]}>|]', 'W')<cr>a"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					require("luasnip").jump(1)
				end,
				mode = "s",
			},
			{
				"<S-Tab>",
				function()
					require("luasnip").jump(-1)
				end,
				mode = { "i", "s" },
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "VeryLazy",
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end

			return {
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
					max_item_count = 15 -- 默认是10
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					-- ["<S-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					-- ["<C-n>"] = cmp.mapping.scroll_docs(-4),
					-- ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
					-- ["<C-p>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-f>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-l>"] = cmp.mapping({
						i = function(fallback)
							if require("luasnip").choice_active() then
								require("luasnip.extras.select_choice")()
							else
								fallback()
							end
						end,
					}),
					["<Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				-- sources = cmp.config.sources({
				sources = {
					{ name = "nvim_lsp",   priority = 2 },
					{ name = "path" },
					{ name = "luasnip",    priority = 4, option = { show_autosnippets = false } },
					{ name = "cmp_tabnine" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "spell" },
					{ name = "calc" },
					{ name = "emoji" },
					{ name = "treesitter" },
					{ name = "crates" },
					-- { name = "copilot",    group_index = 2 },
					-- { name = "copilot",    priority = 1 },
				},
				source_names = {
					nvim_lsp = "(LSP)",
					luasnip = "(SNIP)",
					copilot = "(AI)",
				},
				-- formatting = {
				--     format = function(_, item)
				--         local icons = require("config").icons.kinds
				--         if icons[item.kind] then
				--             item.kind = icons[item.kind] .. item.kind
				--         end
				--         return item
				--     end,
				-- },
				formatting = {
					format = function(entry, vim_item)
						local ft = require("config").formatting
						local max_width = ft.max_width
						if max_width ~= 0 and #vim_item.abbr > max_width then
							vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
						end
						vim_item.kind = ft.kind_icons[vim_item.kind]
						vim_item.menu = ft.source_names[entry.source.name]
						vim_item.dup = ft.duplicates[entry.source.name]
							or ft.duplicates_default
						return vim_item
					end,
				},

				--experimental = {
				--	ghost_text = {
				--		hl_group = "LspCodeLens",
				--	},
				--},
			}
		end,

		config = function(_, opts)
			require("cmp").setup.cmdline("/", {
				mapping = require("cmp").mapping.preset.cmdline(),
				require("cmp").mapping.confirm({ select = true }),
				sources = {
					{ name = "buffer" }
				}
			})

			require("cmp").setup.cmdline(":", {
				mapping = require("cmp").mapping.preset.cmdline(),
				sources = require("cmp").config.sources({
					{ name = "cmdline" }
				}, {
					{ name = "path" }
				})
			})

			require("cmp").setup(opts)
		end,

	},
}

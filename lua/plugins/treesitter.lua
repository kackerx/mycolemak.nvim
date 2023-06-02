return {
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "HiPhish/nvim-ts-rainbow2", 
			'nvim-treesitter/playground' },
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
				-- custom_captures = {
				-- 	-- 把 error 类型高亮为 ErrorMsg 颜色
				-- 	["type.error"] = "ErrorMsg",
				-- }
			},
			indent = { enable = true, disable = { "python" } },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"html",
				-- "javascript",
				"json",
				"lua",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				-- "tsx",
				-- "typescript",
				"vim",
				"yaml",
				"go",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<cr>",
					node_incremental = "<cr>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
			-- textobjects = {
			-- 	select = {
			-- 		enable = true,
			-- 		keymaps = {
			-- 			-- 选择一个函数
			-- 			["af"] = "@function.outer",
			-- 			-- 选择函数内部
			-- 			["if"] = "@function.inner",
			-- 			-- 选择一个参数
			-- 			["aa"] = "@parameter.inner",
			-- 			-- 选择一个参数外部
			-- 			["ia"] = "@parameter.outer",
			-- 		},
			-- 	},
			-- },
			rainbow = {
				enable = false,
				disable = { "jsx", "cpp" },
				-- query = {
				-- 	latex = "rainbow-parens",
				-- },
				-- strategy = {
				-- 	-- Use global strategy by default
				-- 	require("ts-rainbow").strategy["global"],
				-- 	-- Use local for HTML
				-- 	html = require("ts-rainbow").strategy["local"],
				-- 	-- Pick the strategy for LaTeX dynamically based on the buffer size
				-- 	latex = function()
				-- 		-- Disabled for very large files, global strategy for large files,
				-- 		-- local strategy otherwise
				-- 		if vim.fn.line("$") > 10000 then
				-- 			return nil
				-- 		elseif vim.fn.line("$") > 1000 then
				-- 			return require("ts-rainbow").strategy["global"]
				-- 		end
				-- 		return require("ts-rainbow").strategy["local"]
				-- 	end,
				-- },
			},
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = 'o',
				toggle_hl_groups = 'i',
				toggle_injected_languages = 't',
				toggle_anonymous_nodes = 'a',
				toggle_language_display = 'I',
				focus_language = 'f',
				unfocus_language = 'F',
				update = 'R',
				goto_node = '<cr>',
				show_help = '?',
			},
		},
		config = function(_, opts)
			-- Folding
			vim.opt.foldmethod = "expr"
			-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false
			vim.opt.fillchars = "fold: "
			-- vim.opt.foldtext = "==="
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

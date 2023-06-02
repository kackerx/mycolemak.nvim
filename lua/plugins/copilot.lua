return {
	-- 🔥 Copilot
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup {
				suggestion = { enabled = false },
				panel = { enabled = false },
				suggestion = {
					keymap = {
						accept = "<c-i>",
						next = "<c-n>",
						prev = "<c-p>",
						dismiss = "<c-h>",
					},
				},
			}
		end
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = true,
		-- lazy = true,
		-- event = { "InsertEnter", "LspAttach" },
		-- fix_pairs = true,
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}

return {
	{
		"akinsho/bufferline.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function(_, _)
			local bufferline = require('bufferline')
			bufferline.setup {
				options = {
					-- view = "multiwindow",
					view = "tabpages",
					diagnostics = "nvim_lsp",
					separator_style = "none",
					-- style_preset = bufferline.style_preset.minimal,
					always_show_bufferline = true,
					diagnostics_indicator = function(_, _, diag)
						local icons = require("config").icons.diagnostics
						local ret = (diag.error and icons.Error .. diag.error .. " " or "")
							.. (diag.warning and icons.Warn .. diag.warning or "")
						return vim.trim(ret)
					end,
					indicator = {
						icon = ' @ ', -- this should be omitted if indicator style is not 'icon'
						style = 'icon',
					},
					offsets = {
						{
							filetype = "NvimTree",
							text = "K",
							highlight = "Directory",
							text_align = "center",
						},
					},
					-- hover = {
					-- 	enabled = true,
					-- 	delay = 200,
					-- 	reveal = { 'close' }
					-- },
				},
				-- position = "bottom", -- can be "top" or "bottom"
			}
		end,
	},
}

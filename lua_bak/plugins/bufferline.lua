return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
        config = function(_, _)
            local bufferline = require('bufferline')
            bufferline.setup {
                options = {
                    diagnostics = "nvim_lsp",
                    separator_style = "thick",
                    -- style_preset = bufferline.style_preset.minimal, 
                    always_show_bufferline = false,
                    diagnostics_indicator = function(_, _, diag)
                        local icons = require("config").icons.diagnostics
                        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                            .. (diag.warning and icons.Warn .. diag.warning or "")
                        return vim.trim(ret)
                    end,
                    indicator = {
                        icon = '▎', -- this should be omitted if indicator style is not 'icon'
                        style = 'icon',
                    }, 
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "K", 
                            highlight = "Directory",
                            text_align = "left",
                        },
                    },
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = {'close'}
                    }, 
                },
            }
        end, 
	},
}

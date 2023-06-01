return {
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		enabled = true,
		dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter', 'luukvbaal/statuscol.nvim' },
		config = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = false
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.keymap.set('n', 'tO', require('ufo').openAllFolds)
			vim.keymap.set('n', 'tT', require('ufo').closeAllFolds)
			-- vim.keymap.set('n', 'to', require('ufo').openFoldsExceptKinds)
			-- vim.keymap.set('n', 'tt', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			vim.keymap.set('n', 'tk', function()
				local winid = require('ufo').peekFoldedLinesUnderCursor()
				if not winid then
					-- choose one of coc.nvim and nvim lsp
					vim.lsp.buf.hover()
				end
			end)

			local handler = function(virtText, lnum, endLnum, width, truncate)
				local line = vim.fn.getline(lnum)
				if line:find("if%s+err%s*!= nil") then
					-- print(virtText)
					-- virtText = {{"errreturn                 ", "Comment"}}
					-- virtText = virtText..('      ')
					return
				end

				local newVirtText = {}
				local suffix = ('  %d '):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, 'MoreMsg' })
				return newVirtText
			end

			require('ufo').setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { 'treesitter', 'indent' }
				end,
				fold_virt_text_handler = handler,
				open_fold_hl_timeout = 150,
				close_fold_kinds = { 'imports', 'comment' },
				preview = {
					win_config = {
						border = { '', '─', '', '', '', '─', '', '' },
						winhighlight = 'Normal:Folded',
						winblend = 0
					},
					mappings = {
						scrollU = '<C-u>',
						scrollD = '<C-d>',
						jumpTop = '[',
						jumpBot = ']'
					}
				},
			})
		end
	},
	{
		"luukvbaal/statuscol.nvim",
		enabled = false,
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
					{ text = { "%s" },                  click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},
	{
		"Snyssfx/goerr-nvim",
		event = "BufReadPre",
		enabled = false, 
		config = function()
			vim.g.goerr_indent_error = 1
			vim.g.goerr_nvim_indent_level = 4
			vim.g.goerr_nvim_max_width = 1000
			vim.g.goerr_nvim_sign = " "
		end
	}
}

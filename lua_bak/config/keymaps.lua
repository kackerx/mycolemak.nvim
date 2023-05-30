-- This file is automatically loaded by init.lua

local util = require("util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', { silent = true })

-- go to files
map("n", "<leader>go", "<cmd>e ~/.config/nvim/lua/config/options.lua<cr>", { desc = "Go to options config" })
map("n", "<leader>gk", "<cmd>e ~/.config/nvim/lua/config/keymaps.lua<cr>", { desc = "Go to keymaps config" })
map("n", "<leader>gs", function()
	require("luasnip.loaders").edit_snippet_files({})
end, { desc = "Go to luasnip config" })
map("n", "<leader>gp", function()
  require("neo-tree.command").execute({ toggle = true, dir = "~/.config/nvim/lua/plugins" })
end, { desc = "Go to plugins config" })
map(
	"n",
	"<leader>gl",
	"<cmd>Telescope file_browser path=~/.config/nvim/lua/plugins<cr>",
	{ desc = "Go to lazyvim config" }
)

-- better movement, 物理行代替多行的行
map("n", "n", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "e", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "v", "o" }, "H", "^", { desc = "Use 'H' as '^'" })
map({ "n", "v", "o" }, "L", "$", { desc = "Use 'L' as '$'" })

-- move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- window operate
--map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
--map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
--map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
--map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map({"n", "i"}, "<C-j>", "<C-w>w", { desc = "switch window" })
map({"n", "i"}, "<leader>wv", "<C-w>v", { desc = "switch window" })
map({"n", "i"}, "<leader>wx", "<C-w>q", { desc = "switch window" })

-- windows resize and split
-- map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- colemak and custom
map({"n", "v"}, "n", "j", { desc = "down" })
map({"n", "v"}, "e", "k", { desc = "down" })
map({"n", "v"}, "i", "l", { desc = "down" })

map({"n", "v"}, "H", "7h", { desc = "down" })
map({"n", "v"}, "N", "7j", { desc = "down" })
map({"n", "v"}, "I", "7l", { desc = "down" })
map({"n", "v"}, "E", "7k", { desc = "down" })

map("n", "l", "u", { desc = "down" })
map("n", "L", "<C-r>", { desc = "down" })
map("n", "u", "i", { desc = "down" })
map("n", "U", "I", { desc = "down" })

map("c", "<Up>", "<C-p>", { desc = "down" })
map("c", "<Down>", "<C-n>", { desc = "down" })


-- Buffers
map({ "n", "i" }, "<C-a>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader>k", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map({ "n", "i" }, "<C-s>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>j", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>bw", "<cmd>bdelete<cr>", { desc = "Next buffer" })

-- Delete window in `mini.bufremove`
map("n", "<leader>D", "<C-W>c", { desc = "Delete window" })

-- search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
map("n", "k", "n", { desc = "next result" })
map("n", "K", "N", { desc = "prev result" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
--map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
--map({ "i", "v", "n", "s" }, "W", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "W", "<cmd>w<cr>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<", "v<g")
map("n", ">", "v>g")

-- toggle options
-- ===
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- ===
map("n", "<leader>us", function()
	util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
	util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ud", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
	util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- Others
--map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })

map("n", "<D-c>", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- nvim-tree
map({"n", "i"}, "<C-b>", "<cmd>NvimTreeFindFileToggle<cr>", {desc="open or close file explore"})

-- Telescope
map({"n", "i"}, "<C-k>", "<cmd>Telescope oldfiles<cr>", {desc="open or close file explore"})

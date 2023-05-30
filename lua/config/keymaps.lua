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
map({ "n", "i" }, "<C-j>", "<C-w>w", { desc = "switch window" })
map({ "n", "i" }, "<LocalLeader>wv", "<C-w>v", { desc = "switch window" })
map({ "n", "i" }, "<LocalLeader>wx", "<C-w>q", { desc = "switch window" })
-- Delete window in `mini.bufremove`
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })

-- windows resize and split
-- map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- colemak and custom
map({ "n", "v" }, "n", "j", { desc = "down" })
map({ "n", "v" }, "e", "k", { desc = "down" })
map({ "n", "v" }, "i", "l", { desc = "down" })

map({ "n", "v" }, "H", "7h", { desc = "down" })
map({ "n", "v" }, "N", "7j", { desc = "down" })
map({ "n", "v" }, "I", "7l", { desc = "down" })
map({ "n", "v" }, "E", "7k", { desc = "down" })

map("n", "l", "u", { desc = "down" })
map("n", "L", "<C-r>", { desc = "down" })
map("n", "u", "i", { desc = "down" })
map("n", "U", "I", { desc = "down" })

map("n", "m", "~", { desc = "down" })
map("n", "f", "e", { desc = "down" })

map("c", "<Up>", "<C-p>", { desc = "down" })
map("c", "<Down>", "<C-n>", { desc = "down" })

map("n", "T", "<cmd>w<cr>", { desc = "down" })
map("n", "Q", "<cmd>q<cr>", { desc = "down" })

map("n", "tt", "zc", { desc = "down" })
map("n", "to", "zo", { desc = "down" })
map("n", "<leader>tc", "zm", { desc = "down" })
map("n", "<leader>to", "zr", { desc = "down" })

map("n", "cw", "ciw", { desc = "down" })
map("n", "dw", "diw", { desc = "down" })
map("n", "c(", "ci(", { desc = "down" })
map("n", "c[", "ci[", { desc = "down" })
map("n", "d(", "di(", { desc = "down" })
map("n", "d[", "di[", { desc = "down" })
map("n", "c{", "ci{", { desc = "down" })
map("n", "d{", "di{", { desc = "down" })

map("c", "<Tab>", "<Tab><S-Tab>", { desc = "down" })

-- Buffers
map({ "n", "i" }, "<C-a>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader>k", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map({ "n", "i" }, "<C-s>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>j", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<LocalLeader>bw", "<cmd>bdelete<cr>", { desc = "Next buffer" })


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
map("v", "<leader>yy", '"+y', { desc = "Save file" })

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
map({ "n", "i" }, "<LocalLeader>eb", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "open or close file explore" })
map({ "n", "i" }, "<LocalLeader>ec", "<cmd>NvimTreeFindFile<cr>", { desc = "find current buf file in explore" })

------------ Telescope
-- map({"n", "i"}, "<C-k>", "<cmd>Telescope oldfiles<cr>", {desc="open or close file explore"})
map({ "n", "i" }, "<C-k>", "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>",
    { desc = "open or close file explore" })
map({ "n", "i" }, "<LocalLeader>fl", "<cmd>Telescope aerial<CR>", { desc = "open or close file explore" })

map({ "n", "i" }, "<C-r>",
    "<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy({ winblend = 10 }))<CR>",
    { desc = "open or close file explore" })

map("n", "<leader>fi",
    "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>",
    { desc = "impl go interface" })

vim.keymap.set('n', '<leader>wbb', function()
    local ts_utils = require 'nvim-treesitter.ts_utils'
    print(ts_utils.get_node_at_cursor(0):parent():type())
end
)

vim.keymap.set({ "n", "i" }, '<LocalLeader>lz', function()
    local ts_utils = require 'nvim-treesitter.ts_utils'
    -- local result = vim.treesitter.get_node()
    if (ts_utils.get_node_at_cursor(0):parent():type() == "function_declaration") or (ts_utils.get_node_at_cursor(0):parent():type() == "type_spec") then
        require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({ winblend = 10 }))
    else
        require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({ winblend = 10 }))
    end
end, { desc = "" })

-- hop
map('n', 's', "<cmd>HopWord<cr>", {})

------------ session manager
map({ "n", "i" }, '<LocalLeader>ws', "<cmd>SessionManager load_session<cr>", {})

------------ toggleTerm
map({ "n", "i" }, '<C-y>', "<cmd>ToggleTerm<cr>", {})

------------ debug
map({ "n", "i" }, '<LocalLeader>db',
    "<cmd>lua require'dap'.toggle_breakpoint(); require'dap.dap-util'.store_breakpoints(true)<cr>", {})
map({ "n", "i" }, '<LocalLeader>dp', "<cmd>lua require'dap'.continue()<cr>", {})
map({ "n", "i" }, '<LocalLeader>dq', "<cmd>lua require'dap'.step_over()<cr>", {})
map({ "n", "i" }, '<LocalLeader>dw', "<cmd>lua require'dap'.step_into()<cr>", {})
map({ "n", "i" }, '<LocalLeader>df', "<cmd>lua require'dap'.step_out()<cr>", {})
map({ "n", "i" }, '<LocalLeader>dt', "<cmd>lua require'dap'.terminate()<cr>", {})
map({ "n", "i" }, '<LocalLeader>dr', "lua require'dap.dap-util'.reload_continue()<CR>", {})
map({ "n", "i" }, '<LocalLeader>dl', "<cmd>lua require'dap'.run_last()<cr>", {})
map({ "n", "i" }, '<LocalLeader>de', "<cmd>lua require'dapui'.eval()<cr>", {})
map({ "n", "i" }, '<LocalLeader>du', "<cmd>lua require'dapui'.toggle()<cr>", {})

------------ trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
    { silent = true, noremap = true }
)
map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true }
)
map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
    { silent = true, noremap = true }
)

------------ lsp_signature
map({ 'n', 'i' }, '<LocalLeader>os', function()
    require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

return {
    {
        "KeitaNakamura/neodark.vim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme neodark]])
        end,
    },
    {
        "phanviet/vim-monokai-pro",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1001, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme monokai_pro]])
        end,
    },
    {
        "RRethy/nvim-base16",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1001, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme base16-tender]])
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1001, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        "marko-cerovac/material.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1001, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme material]])
        end,
    },
}

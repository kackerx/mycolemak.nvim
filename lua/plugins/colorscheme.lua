return {
    {
        "sainnhe/sonokai",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[
                let g:sonokai_style = 'espresso'
                let g:sonokai_better_performance = 1
                colorscheme sonokai
            ]])
        end,
    },
}

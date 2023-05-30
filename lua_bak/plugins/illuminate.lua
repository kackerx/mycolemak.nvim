return {
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy", 
        config = function(_, _)
            vim.g.Illuminate_ftblacklist = {
                "NvimTree",
                "vista_kind",
                "toggleterm"
            }
        end,
    }
}

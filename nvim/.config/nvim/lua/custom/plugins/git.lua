-- Git
return {

    {
        'tpope/vim-fugitive',
        event = "VeryLazy"
    },

    {
        "lewis6991/gitsigns.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        event = "VeryLazy",
        config = function()
            require("custom.gitsigns")
        end
    },

}

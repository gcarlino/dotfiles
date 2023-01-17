-- Git
return {
    {
        'lewis6991/gitsigns.nvim',
        event = "BufReadPre",
        config = function ()
            require('beps.plugins.gitsigns')
        end
    },
    {
        'tpope/vim-fugitive',
        event = "VeryLazy"
    },
    {
        'sindrets/diffview.nvim',
        event = "VeryLazy",
        config = function ()
            require('beps.plugins.diffview')
        end
    }
}

-- Git
return {
    { 'tpope/vim-fugitive', },
    { 'lewis6991/gitsigns.nvim',
        config = function ()
            require('beps.plugins.gitsigns')
        end
    },
    {
        'sindrets/diffview.nvim',
        event = "BufReadPost",
        config = function ()
            require('beps.plugins.diffview')
        end
    }
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = "BufReadPost",
        build = ':TSUpdate',
        config = function ()
            require('beps.plugins.treesitter')
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'nvim-treesitter/playground' },
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        event = "BufReadPost",
        config = function ()
            require('beps.plugins.treesitter')
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true },
    { 'nvim-treesitter/playground', event = "VeryLazy" },
}

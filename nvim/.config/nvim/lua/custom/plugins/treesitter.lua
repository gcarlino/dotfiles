return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function ()
            require('beps.plugins.treesitter')
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    },
}

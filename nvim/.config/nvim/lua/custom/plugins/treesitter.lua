return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        -- event = "VeryLazy",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        build = ":TSUpdate",
        config = function ()
            require('beps.plugins.treesitter')
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    },
}

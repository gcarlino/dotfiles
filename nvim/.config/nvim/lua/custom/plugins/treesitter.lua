return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufNewFile" },
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function ()
            require('beps.plugins.treesitter')
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        }
    },
}

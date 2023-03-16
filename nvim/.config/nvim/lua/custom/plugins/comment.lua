return {
    {
        'numToStr/Comment.nvim',
        event = { "BufReadPost", "BufNewFile" },
        -- event = "VeryLazy",
        config = function()
            require('Comment').setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        -- event = "VeryLazy",
        config = function()
            require("todo-comments").setup {
            }
        end
    }
}

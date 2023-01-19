return {
    {
        'numToStr/Comment.nvim',
        -- event = "BufReadPost",
        event = "VeryLazy",
        config = function()
            require('Comment').setup()
        end
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        config = function()
            require("todo-comments").setup {
            }
        end
    }
}

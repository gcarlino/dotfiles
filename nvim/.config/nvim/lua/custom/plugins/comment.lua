return {
    {
        'numToStr/Comment.nvim',
        -- event = "BufReadPost",
        event = "VeryLazy",
        config = function()
            require('Comment').setup()
        end
    },
}

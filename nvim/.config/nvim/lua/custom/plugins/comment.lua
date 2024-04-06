return {
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        enabled = false,
        opts = {},
        -- config = function ()
        --     -- vim.keymap.set("n", "<D-/>", ":lua require('Comment.api').toggle.linewise.current(); vim.cmd('normal j')<CR>", {silent=true})
        --     vim.keymap.set("n", "<D-/>", ":lua require('Comment.api').toggle.linewise.current()<CR>", {silent=true})
        --     vim.keymap.set("v", "<D-/>", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {silent=true})
        -- end
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    }
}

-- Git
return {

    {
        'tpope/vim-fugitive',
        event = "VeryLazy"
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("custom.gitsigns")
        end
    },

    {
        'sindrets/diffview.nvim',
        enabled = false,
        event = "VeryLazy",
        cmd = "DiffviewOpen",
        keys = {
            { '<leader>vo', ':DiffviewOpen<CR>', desc = "Open Diffview tab."},
            { '<leader>vc', ':DiffviewClose<CR>', desc = "Close Diffview tab."},
        },
        config = function ()
            require('diffview').setup({
                enhanced_diff_hl = true,
                view = {
                    merge_tool = {
                        layout = "diff3_mixed"
                    }
                },
            })
            vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'
        end,
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    }
}

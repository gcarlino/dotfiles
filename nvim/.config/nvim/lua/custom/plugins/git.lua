-- Git
return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function ()
            require("beps.plugins.gitsigns")
        end
    },

    {
        'tpope/vim-fugitive',
        cmd = 'G',
    },

    {
        'sindrets/diffview.nvim',
        keys = {
            { '<leader>vo', ':DiffviewOpen<CR>', desc = "Open Diffview tab."},
            { '<leader>vc', ':DiffviewClose<CR>', desc = "Close Diffview tab."},
        },
        config = function ()
            -- require('beps.plugins.diffview')
            require('diffview').setup({
                view = {
                    default = {
                        layout = "diff2_horizontal",
                        -- layout = "diff2_vertical",
                    },
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

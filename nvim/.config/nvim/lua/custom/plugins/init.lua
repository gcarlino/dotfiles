return {

    { "nvim-lua/plenary.nvim", },

    { "nvim-tree/nvim-web-devicons", },

    {
        "emmanueltouzery/decisive.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>cca", ":lua require('decisive').align_csv({})<CR>", desc = "Align CSV"},
            { "<leader>ccA", ":lua require('decisive').align_csv_clear({})<CR>", desc = "Align CSV clear"},
       }
    },

    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            {
                "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics toggle (Trouble)",
            },
            {
                "<leader>xl", "<cmd>Trouble loclist toggle<cr>",
                desc = "Location list (Trouble)",
            },
            {
                "<leader>xq", "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix list (Trouble)",
            },
            {
                "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xd", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP definitions / references / ... (Trouble)",
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = 'NvimTreeToggle',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            { '<leader>n', ':NvimTreeToggle<CR>', desc = "Toggle nvim-tree", silent = true }
        },
        opts = {
            view = {
                width = 35,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
            actions = {
                -- Disable window picker to work better with splits
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
        },
    },

    {
        "lervag/vimtex",
        lazy = false,
        ft = "tex",
        init = function()
            vim.g.vimtex_view_method = 'skim'
            vim.g.vimtex_view_skim_activate = 1
            vim.g.vimtex_view_skim_reading_bar = 1
            vim.g.vimtex_view_skim_no_select = 1
            vim.g.vimtex_quickfix_ignore_filters = { 'Underfull' }
        end
    },

    -- Various
    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        opts = {
            open_mapping = [[<c-q>]],
        }
    },

    {
        "kylechui/nvim-surround",
        event = 'VeryLazy',
        opts = {},
    },

}

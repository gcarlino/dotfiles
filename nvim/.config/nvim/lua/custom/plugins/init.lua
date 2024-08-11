return {
    { "nvim-lua/plenary.nvim", lazy = true },

    {
        "emmanueltouzery/decisive.nvim",
        keys = {
            { "<leader>cca", ":lua require('decisive').align_csv({})<CR>", desc = "Align CSV"},
            { "<leader>ccA", ":lua require('decisive').align_csv_clear({})<CR>", desc = "Align CSV clear"},
        }
    },

    {
        "folke/trouble.nvim",
        cmd = "Trouble",
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
            { '<leader>n', ':NvimTreeToggle<CR>', desc = "Toggle nvim-tree" }
        },
        opts = {
            renderer = {
                indent_markers = {
                    enable = true,
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
        "windwp/nvim-autopairs",
        enabled = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    {
        "akinsho/toggleterm.nvim",
        event = 'VeryLazy',
        opts = {
            open_mapping = [[<c-q>]],
        }
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require('nvim-surround').setup()
        end
    },

    {
        "linux-cultist/venv-selector.nvim",
        ft = "python",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope.nvim"
        },
        branch = "regexp",
        config = function ()
            require("venv-selector").setup()
        end,
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "VenvSelect" }
        },
    },

}

return {

    { "nvim-lua/plenary.nvim", },

    { "nvim-tree/nvim-web-devicons", },

    {
        "emmanueltouzery/decisive.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>ca", ":lua require('decisive').align_csv({})<CR>", desc = "Align CSV"},
            { "<leader>cA", ":lua require('decisive').align_csv_clear({})<CR>", desc = "Align CSV clear"},
       }
    },

    { "nvzone/volt", lazy = true },

    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
        keys = {
            { "<leader>tc", function () require("minty.shades").open() end, desc = "Toggle [c]olor plaette" },
        },
        config = function ()
        end
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
        'stevearc/oil.nvim',
        cmd = { "Oil" },
        opts = {},
        keys = {
          { "<leader>,", "<cmd>Oil<cr>", desc = "Oil" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- config = function()
        --     require("oil").setup()
        -- end
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
        "kylechui/nvim-surround",
        event = 'VeryLazy',
        opts = {},
    },

}

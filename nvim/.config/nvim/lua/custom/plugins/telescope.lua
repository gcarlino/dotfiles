return {
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.1',
        -- cmd = 'Telescope',
        event = "VeryLazy",
        config = function()
            require('beps.plugins.telescope')
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                enabled = vim.fn.executable("make") == 1,
                build = 'make'
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            "nvim-telescope/telescope-dap.nvim",
        }
    },

    {
        "nvim-lua/plenary.nvim",
        event = "VeryLazy"
    },

    {
        "debugloop/telescope-undo.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        keys = {
            {
                "<leader>u",
                "<cmd>Telescope undo<cr>",
                desc = "  undo history.",
            },
        },
        opts = {
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.5,
                    }
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end,
    },

    {
        "jonarrien/telescope-cmdline.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
            },
        },
        keys = {
            {
                "<leader>fc",
                "<cmd>Telescope cmdline<cr>",
                desc = "  Telescope commandline."
            },
        },
        opts = {},
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("cmdline")
        end
    }
}

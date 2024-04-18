return {
    {
        'nvim-telescope/telescope.nvim',
        -- cmd = 'Telescope',
        event = 'VimEnter',
        config = function()
            require('beps.plugins.telescope')
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            -- { "nvim-telescope/telescope-dap.nvim" },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons' },
            {
                "debugloop/telescope-undo.nvim",
                enabled = false,
                -- dependencies = {
                --     {
                --         "nvim-telescope/telescope.nvim",
                --         dependencies = { "nvim-lua/plenary.nvim" },
                --     },
                -- },
                keys = {
                    {
                        "<leader>u",
                        "<cmd>Telescope undo<cr>",
                        desc = " undo history.",
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
                enabled = false,
                -- dependencies = {
                --     {
                --         "nvim-telescope/telescope.nvim",
                --         dependencies = { "nvim-lua/plenary.nvim" },
                --     },
                -- },
                keys = {
                    {
                        "<leader>fc",
                        "<cmd>Telescope cmdline<cr>",
                        desc = " Telescope commandline."
                    },
                },
                opts = {},
                config = function(_, opts)
                    require("telescope").setup(opts)
                    require("telescope").load_extension("cmdline")
                end
            }
        }
    },


}

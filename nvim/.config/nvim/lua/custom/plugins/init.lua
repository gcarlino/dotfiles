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
        -- event = { "BufReadPost", "BufNewFile" },
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- opts = {
        --     mode = "document_diagnostics"
        -- },
        config = function()
            require('trouble').setup({})
            vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end,
                { silent = true, noremap = true, desc = "Trouble: toggle the list." }
            )
            vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
                { silent = true, noremap = true, desc = "Trouble: workspace diagnostics." }
            )
            vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
                { silent = true, noremap = true, desc = "Trouble: document diagnostics." }
            )
            vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end,
                { silent = true, noremap = true, desc = "Trouble: items from the window's location list." }
            )
            vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end,
                { silent = true, noremap = true, desc = "Trouble: quickfix items." }
            )
            vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end,
                { silent = true, noremap = true, desc = "Trouble: references of the word under the cursor." }
            )
        end,
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
        opts = { },
    },

    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_view_method = 'skim'
            vim.g.vimtex_view_skim_activate = 1
            vim.g.vimtex_view_skim_reading_bar = 1
            vim.g.vimtex_view_skim_no_select = 1
        end
    },

    -- Various
    {
        "windwp/nvim-autopairs",
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
        config = true,
        ft = "python",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim"
        },

        {
            'stevearc/oil.nvim',
            opts = {
                view_options = {
                    show_hidden = true,
                },
            },
            -- Optional dependencies
            dependencies = { "nvim-tree/nvim-web-devicons" },
        }   },
}

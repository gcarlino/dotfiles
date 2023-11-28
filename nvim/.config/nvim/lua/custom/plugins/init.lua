return {
    -- { "nvim-lua/plenary.nvim", lazy = true },

    {
        "folke/trouble.nvim",
        event = { "BufReadPost", "BufNewFile" },
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
        verstion = "*",
        cmd = 'NvimTreeToggle',
        keys = {
            { '<leader>n', ':NvimTreeToggle<CR>', desc = "Toggle nvim-tree" }
        },
        config = function()
            require('nvim-tree').setup({
                view = {
                    width = 30,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    custom = { '.DS_Store' }
                }
            })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },

    {
        "jalvesaq/Nvim-R",
        ft = 'r',
        config = function()
            vim.cmd([[
                let R_assign_map = '<M-->'
                let rout_follow_colorscheme = 1
                let r_syntax_folding = 1

                " For radian
                let R_app = "radian"
                let R_cmd = "R"
                let R_hl_term = 0
                let R_args = ['--no-save']
                let R_bracketed_paste = 1

                set nofoldenable
                autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
            ]])
        end,
    },

    {
        "lervag/vimtex",
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
        "mechatroner/rainbow_csv",
        event = 'VeryLazy'
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
    },
}

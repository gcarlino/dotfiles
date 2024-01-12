return {

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
        opts = {
            window = {
                border = "single",
            },
            disable = {
                buftypes = {},
                filetypes = { "TelescopePrompt" },
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("beps.plugins.gitsigns")
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('beps.plugins.lualine')
        end,
    },

    {
        "akinsho/bufferline.nvim",
        event = "TabNew",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        },
        opts = {
            options = {
                mode = "tabs",
                show_buffer_close_icons = false,
                show_close_icon = false,
                always_show_bufferline = false,
            },
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        event = "VeryLazy",
        config = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:❯]]
            vim.cmd("highlight FoldColumn guifg=" .. vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg'))

            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                setopt = true,
                relculright = true,
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa", },
                    {
                        text = { builtin.lnumfunc, " " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScLa",
                    },
                    { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", },
                },
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                    tab_char = "▏",
                },
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                    include = {
                        node_type = {
                            lua = {
                                "return_statement",
                                "table_constructor"
                            }
                        }
                    }
                }
            })
        end
    },

    {
        'lukas-reineke/virt-column.nvim',
        enabled = false,
        event = "VeryLazy",
        config = function()
            require('virt-column').setup({
                char = "│",
            })
        end
    },

}

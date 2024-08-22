return {

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            delay = 800,
            spec = {
                { "<leader>c", group = "[C]ode" },
                { "<leader>d", group = "[D]AP" },
                { "<leader>f", group = "[F]ind", icon = ""},
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
                { "<leader>l", group = "[L]SP" },
                { "<leader>o", group = "[O]bsidian" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>w", group = "[W]orkspace" },
                { "<leader>x", group = "Trouble" },
            },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('custom.lualine')
        end,
    },

    {
        "akinsho/bufferline.nvim",
        event = "TabNew",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- keys = {
        --     { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
        --     { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        -- },
        opts = {
            options = {
                mode = "tabs",
                show_buffer_close_icons = false,
                show_close_icon = false,
                always_show_bufferline = false,
                separator_style = "thick",
            },
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        event = "VeryLazy",
        config = function()
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
                    {
                        text = { builtin.foldfunc, " " },
                        click = "v:lua.ScFa",
                        -- hi = "NonText",
                    },
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
        event = "VeryLazy",
        enabled = true,
        opts = {
            char = "│",
            highlight = "iblindent",
            virtcolumn = "80, 120",
        }
    },

}

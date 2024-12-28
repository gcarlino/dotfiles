return {

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)"
            },
        },
        opts = {
            preset = "helix",
            delay = 800,
            spec = {
                { "<leader>c", group = "[C]SV" },
                { "<leader>d", group = "[D]AP" },
                { "<leader>f", group = "[F]ind", icon = ""},
                { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
                { "<leader>l", group = "[L]SP" },
                { "<leader>o", group = "[O]bsidian" },
                { "<leader>s", group = "[S]imularia" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>w", group = "[W]orkspace" },
                { "<leader>x", group = "Trouble" },
            },
        },
    },

    {
        'nvim-lualine/lualine.nvim',
        event = "UIEnter",
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
        event = "UIEnter",
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
        event = "UIEnter",
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
        event = "UIEnter",
        enabled = true,
        opts = {
            char = "│",
            highlight = "iblindent",
            virtcolumn = "80, 120",
            exclude = { filetypes = { "markdown", "fugitive" } }
        }
    },

}

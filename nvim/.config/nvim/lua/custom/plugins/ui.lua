return {

    { "nvim-tree/nvim-web-devicons", lazy = true },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        enables = false,
        config = function()
            -- vim.o.timeout = true
            -- vim.o.timeoutlen = 400
            require("which-key").setup({
                window = {
                    border = 'single'
                },
                disable = {
                    buftypes = {},
                    filetypes = { "TelescopePrompt" },
                },
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        -- event = "VeryLazy",
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
        'alvarosevilla95/luatab.nvim',
        event = "VeryLazy",
        config = function()
            require("luatab").setup({
                separator = function() return '' end,
                modified = function() return '' end,
            })
        end
    },

    {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        event = "VeryLazy",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                setopt = true,
                relculright = true,
                segments = {
                    { text = { "%s" },             click = "v:lua.ScSa" },
                    {
                        text = { builtin.lnumfunc, " " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScLa",
                    },
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
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

    {
        'chentoast/marks.nvim',
        enabled = false,
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('marks').setup()
        end,
    },
}

return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        -- event = { "BufReadPre", "BufNewFile" },
        config = function ()
            require("beps.plugins.gitsigns")
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            require('beps.plugins.lualine')
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
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
                    { text = { "%s" }, click = "v:lua.ScSa" },
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
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            -- scope = { enabled = false },
            scope = {
                show_start = false,
                show_end = false,
                include = {
                    node_type = {
                        lua = {
                            "return_statement",
                            "table_constructor"
                        },
                    }
                }
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
        main = "ibl",
    },

    {
        'lukas-reineke/virt-column.nvim',
        enabled = false,
        event = "VeryLazy",
        config = function ()
            require('virt-column').setup({
                char = "│" ,
            })
        end
    },

    {
        'chentoast/marks.nvim',
        enabled = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('marks').setup()
        end,
    },
}


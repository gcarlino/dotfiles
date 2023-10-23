return {

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
        enabled = true,
        main = "ibl",
        config = function ()
            require("ibl").setup( {
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
                indent = {
                    char = "│" ,
                },
            }

            )
        end
    },

    {
        'lukas-reineke/virt-column.nvim',
        enabled = false,
        event = { "BufReadPost", "BufNewFile" },
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


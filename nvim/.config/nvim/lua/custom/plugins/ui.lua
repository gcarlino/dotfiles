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
        "luukvbaal/statuscol.nvim", config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                setopt = true,
                relculright = true,
                segments = {
                    {
                        sign = {
                            name = { ".*" },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            wrap = true
                        },
                        click = "v:lua.ScSa"
                    },
                    {
                        sign = {
                            name = { "DiagnosticSign" },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = false
                        },
                        click = "v:lua.ScSa"
                    },
                    { text = { builtin.lnumfunc },
                        auto = true,
                        click = "v:lua.ScLa", },
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                }
            })
        end,
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        opts = {},
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("ibl").setup( {
                indent = {
                    char = "│" ,
                },
                scope = {
                    enabled = true
                }
            })
        end,
    },

    {
        'lukas-reineke/virt-column.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require('virt-column').setup({
                char = "│" ,
            })
        end
    },

    {
        'chentoast/marks.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('marks').setup()
        end,
    },
}


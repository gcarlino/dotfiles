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
        'kevinhwang91/nvim-ufo',
        event = "VeryLazy",
        dependencies = {
            { 'kevinhwang91/promise-async' },
            {
                'luukvbaal/statuscol.nvim',
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup({
                        relculright = true,
                        segments = {
                            {text = {"%s"}, click = "v:lua.ScSa"},
                            {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"},
                            {
                                text = {builtin.foldfunc, " "},
                                click = "v:lua.ScFa",
                            }
                        }
                    })
                end
            },
        },
        config = function ()
            -- Fold options
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            -- Treesitter as the main provider
            require("ufo").setup({
                provider_selector = function (bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('indent_blankline').setup({
                show_current_context = true,
            })
        end,
    },

    {
        'lukas-reineke/virt-column.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require('virt-column').setup({
                char = "│"
            })
        end
    },

    {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
    },

    {
        'chentoast/marks.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('marks').setup()
        end,
    },
}


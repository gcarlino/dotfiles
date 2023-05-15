return {
    {
        'EdenEast/nightfox.nvim',
        -- event = "VimEnter",
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function()
            require('nightfox').setup({
                options = {
                    terminal_colors = false,
                    styles = {
                        comments = 'italic',
                    }
                }
            })
            vim.cmd.colorscheme('nordfox')
        end,
    },

    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function ()
            vim.g.edge_style='aura'
            vim.g.edge_better_performance = 1
            vim.cmd.colorscheme('edge')
        end
    },

    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        enabled = false,
        config = function ()
            require('catppuccin').setup({
                flavour = "macchiato",
                background = {
                    dark = 'macchiato',
                    light = 'latte',
                },
            })
            vim.cmd.colorscheme('catppuccin-macchiato')
        end
    },

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        enabled = true,
        config = function ()
            require('onedark').setup({
                style = 'dark',
                toggle_style_key = '<leader>ts',
            })
            require('onedark').load()
        end
    },

    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function ()
            require('tokyonight').setup({
                style = 'storm',
                light_style = 'day',
                styles = {
                    floats = 'dark'
                },
                sidebars = { "qf", "help" },
                lualine_bold = false,
            })
            vim.cmd.colorscheme('tokyonight')
        end
    }
}

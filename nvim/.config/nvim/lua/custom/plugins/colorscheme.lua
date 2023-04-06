return {
    {
        'EdenEast/nightfox.nvim',
        -- event = "VimEnter",
        lazy = false,
        priority = 1000,
        enabled = true,
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
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        enabled = false,
        config = function ()
            require('catppuccin').setup({
                flavour = "frappe",
                background = {
                    dark = 'frappe',
                    light = 'latte',
                },
            })
            vim.cmd.colorscheme('catppuccin')
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

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
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
        enabled = false,
        config = function ()
            require('rose-pine').setup({
                variant = 'moon'
            })
            vim.cmd.colorscheme('rose-pine')
        end
    },

    {
          "olimorris/onedarkpro.nvim",
          priority = 1000,
          enabled = false,
          config = function ()
            vim.cmd.colorscheme('onedark')
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

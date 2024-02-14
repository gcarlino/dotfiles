return {

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        enabled = true,
        config = function()
            vim.o.background='light'
            require('onedark').setup({
                style = 'light',
            })
            require('onedark').load()
        end
    },

    {
        'catppuccin/nvim',
        name = 'catppuccin',
        enabled = true,
        opts = {
            integrations = {
                cmp = true,
                gitsigns = true,
                indent_blankline = { enabled = true },
                markdown = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
                neotree = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    }
                }
            },
        },
    },

    {
        "arzg/vim-colors-xcode",
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme('xcode')
        end
    },

    {
        'EdenEast/nightfox.nvim',
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
            -- vim.cmd.colorscheme('nordfox')
        end,
    },

    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            vim.g.edge_style = 'aura'
            vim.g.edge_better_performance = 1
            -- vim.cmd.colorscheme('edge')
        end
    },

    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            require('tokyonight').setup({
                style = 'storm',
                light_style = 'day',
                styles = {
                    floats = 'dark'
                },
                sidebars = { "qf", "help" },
                lualine_bold = false,
            })
            -- vim.cmd.colorscheme('tokyonight')
        end
    },

    {
        'projekt0n/github-nvim-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        enabled = true,
        config = function()
            require('github-theme').setup({
                -- ...
            })
            -- vim.cmd.colorscheme("github_light")
        end,
    }
}

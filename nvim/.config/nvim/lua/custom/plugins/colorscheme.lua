return {

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        enabled = false,
        config = function()
            vim.o.background='light'
            require('onedark').setup({
                style = 'light',
            })
            require('onedark').load()
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
            vim.cmd.colorscheme('tokyonight-storm')
        end
    },

}

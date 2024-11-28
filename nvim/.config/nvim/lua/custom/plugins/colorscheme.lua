return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        cond = true,
        config = function()
            -- Custom color for split line
            require('tokyonight').setup {
                on_colors = function(c)
                    c.border = c.blue0
                end,
            }
            vim.cmd.colorscheme('tokyonight-storm')
        end
    },

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        cond = false,
        opts = function()
            require('onedark').setup({
                style = 'dark',
                toggle_style_key = "<leader>tc",
                toggle_style_list = { 'dark', 'light' },
            })
            require('onedark').load()
        end
    },

}

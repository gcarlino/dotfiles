return {
    {
        'EdenEast/nightfox.nvim',
        event = "VimEnter",
        priority = 1000,
        enabled = false,
        config = function()
            require('nightfox').setup({
                terminal_colors = false
            })
            vim.cmd.colorscheme('nordfox')
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        enabled = true,
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
    }
}

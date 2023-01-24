return {

    {
        'EdenEast/nightfox.nvim',
        event = "VimEnter",
        priority = 1000,
        config = function()
            require('nightfox').setup({
                terminal_colors = false
            })
            vim.cmd.colorscheme('nordfox')
        end,
    }
}

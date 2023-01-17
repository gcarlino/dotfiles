return {

    { 'https://github.com/sainnhe/edge', enable = false },

    { 'navarasu/onedark.nvim', enable = false },

    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        config = function()
            require('nightfox').setup({
                terminal_colors = false
            })
            vim.cmd.colorscheme('nordfox')
        end,
    }
}

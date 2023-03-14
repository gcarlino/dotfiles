return {
    {
        'nvim-telescope/telescope.nvim',
        -- priority = 100,
        cmd = 'Telescope',
        config = function()
            require('beps.plugins.telescope')
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    { 'nvim-telescope/telescope-ui-select.nvim', event = 'VeryLazy' },
    { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' },
}

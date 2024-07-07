return {
    {
        'nvim-telescope/telescope.nvim',
        -- cmd = 'Telescope',
        event = 'VimEnter',
        config = function()
            require('custom.telescope')
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            -- { "nvim-telescope/telescope-dap.nvim" },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons' },
        }
    },
}

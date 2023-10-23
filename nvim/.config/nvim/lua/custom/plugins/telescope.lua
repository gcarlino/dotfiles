return {
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.1',
        cmd = 'Telescope',
        -- event = "VeryLazy",
        config = function()
            require('beps.plugins.telescope')
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim',
                enabled = vim.fn.executable("make") == 1,
                build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            "nvim-telescope/telescope-dap.nvim" ,
        }
    },
}

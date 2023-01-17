return {
    {
        'nvim-telescope/telescope.nvim',
        -- priority = 100,
        cmd = "Telescope",
        config = function()
            require('beps.plugins.telescope')
        end,
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "debugloop/telescope-undo.nvim" },
}

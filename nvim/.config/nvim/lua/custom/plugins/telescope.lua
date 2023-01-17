return {
    {
        'nvim-telescope/telescope.nvim',
        -- priority = 100,
        cmd = "Telescope",
        config = function()
            require('beps.plugins.telescope')
        end,
    },
    { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "debugloop/telescope-undo.nvim", lazy = true, enable = false },
}

return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        config = function()
            require('beps.plugins.lualine')
        end
    },
    {
        'alvarosevilla95/luatab.nvim',
        event = "VeryLazy",
        config = function()
            require("luatab").setup({
                separator = function() return '' end,
                modified = function() return '' end,
            })
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "VeryLazy",
        -- event = "BufReadPre",
        config = function()
            require('indent_blankline').setup()
        end,
    },
    {
        'kyazdani42/nvim-web-devicons',
        lazy = true
    },
}

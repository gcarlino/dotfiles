-- Completion
return {
    {
        'L3MON4D3/LuaSnip',
        event = 'InsertCharPre',
        dependencies = {
            "rafamadriz/friendly-snippets",
            -- "saadparwaiz1/cmp_luasnip",
        }
    },

    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = { 'InsertEnter', 'CmdlineEnter'},
        config = function ()
            require('beps.plugins.nvim-cmp')
        end,
        dependencies = {
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'rcarriga/cmp-dap',
            'jalvesaq/cmp-nvim-r',
            'onsails/lspkind-nvim',
            'kdheepak/cmp-latex-symbols',
            "saadparwaiz1/cmp_luasnip",
        },
    },
}

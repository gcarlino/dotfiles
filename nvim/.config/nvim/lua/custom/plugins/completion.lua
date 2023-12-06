-- Completion
return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = { 'InsertEnter', 'CmdlineEnter'},
        config = function ()
            require('beps.plugins.nvim-cmp')
        end,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            "rafamadriz/friendly-snippets",
            'saadparwaiz1/cmp_luasnip',
            'rcarriga/cmp-dap',
            'jalvesaq/cmp-nvim-r',
            'kdheepak/cmp-latex-symbols',
        },
    },

    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        -- event = 'InsertCharPre',
        dependencies = {
            "rafamadriz/friendly-snippets",
            -- "saadparwaiz1/cmp_luasnip",
        },
        config = function ()
            require('luasnip.loaders.from_vscode').lazy_load()
        end
    },

}

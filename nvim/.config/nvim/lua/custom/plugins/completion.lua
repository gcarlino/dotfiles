-- Completion
return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        config = function ()
            require('beps.plugins.nvim-cmp')
        end,
        dependencies = {
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-nvim-lsp'  },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'jalvesaq/cmp-nvim-r' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'rcarriga/cmp-dap' },
            { 'kdheepak/cmp-latex-symbols' },
            { 'onsails/lspkind-nvim' },
        }
    },

    {
        "saadparwaiz1/cmp_luasnip",
        ft = "lua",
        dependencies = { "L3MON4D3/LuaSnip" }
    },

    { 'L3MON4D3/LuaSnip', lazy = true }
}

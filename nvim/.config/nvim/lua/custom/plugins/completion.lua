-- Completion
return {
    {
        'hrsh7th/nvim-cmp',
        event = "VeryLazy",
        config = function ()
            require('beps.plugins.nvim-cmp')
        end
    },
    { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'kdheepak/cmp-latex-symbols' },
    { 'rcarriga/cmp-dap' },
    { 'onsails/lspkind-nvim' },
}

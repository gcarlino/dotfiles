-- Completion
return {

    {
        "hrsh7th/nvim-cmp",
        event = { 'InsertEnter', 'CmdlineEnter'},
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            {
                'L3MON4D3/LuaSnip',
                build = (function ()
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
            },
            'saadparwaiz1/cmp_luasnip',
            'rcarriga/cmp-dap',
            "R-nvim/cmp-r",
            'kdheepak/cmp-latex-symbols',
        },
        config = function ()
            require('beps.plugins.nvim-cmp')
        end,
    },

}

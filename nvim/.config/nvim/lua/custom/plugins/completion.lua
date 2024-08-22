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
            {
                'L3MON4D3/LuaSnip',
                build = "make install_jsregexp",
                opts = {},
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    config = function ()
                        require('luasnip.loaders.from_vscode').lazy_load()
                        require('luasnip.loaders.from_snipmate').lazy_load({paths = {"./snippets"}})
                    end
                },
            },
            "saadparwaiz1/cmp_luasnip",
            {
                "R-nvim/cmp-r",
                opts = {},
            },
            "micangl/cmp-vimtex",
            'kdheepak/cmp-latex-symbols',
        },
        config = function ()
            require('custom.completion')
        end,
    },

}

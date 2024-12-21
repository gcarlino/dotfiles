-- Completion
return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            completion = {
                menu = {
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 }
                        },
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
                },
            },
        },
        opts_extend = { "sources.default", "lazydev" }
    },

    {
        "hrsh7th/nvim-cmp",
        enabled = false,
        event = { 'InsertEnter' },
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

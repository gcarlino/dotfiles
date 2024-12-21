-- Completion
return {

    {
        'saghen/blink.compat',
        enabled = true,
        version = '*',
        lazy = true,
        opts = { enable_cmp_integration = true },
    },

    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            "R-nvim/cmp-r",
            "micangl/cmp-vimtex",
            'kdheepak/cmp-latex-symbols',
        },
        version = '*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            signature = {
                enabled = true,
            },
            completion = {
                menu = {
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer',
                    'latex_symbols', 'cmp_r', 'lazydev', 'vimtex' },

                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                     cmp_r = {
                        name = "cmp_r",
                        module = "blink.compat.source",
                        score_offset = 100,
                    },
                    latex_symbols = { name = "latex_symbols", module = "blink.compat.source", },
                    vimtex = { name = 'vimtex', module = 'blink.compat.source' },
                },
            },
        },
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

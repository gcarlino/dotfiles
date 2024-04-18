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
                version = "v2.*",
                lazy = true,
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                config = function ()
                    local ls = require("luasnip")
                    ls.config.set_config({
                        history = true,
                        updateevents = "TextChanged,TextChangedI"
                    })
                    require('luasnip.loaders.from_vscode').lazy_load()
                end
            },
            'saadparwaiz1/cmp_luasnip',
            -- 'rcarriga/cmp-dap',
            "R-nvim/cmp-r",
            'kdheepak/cmp-latex-symbols',
        },
        config = function ()
            require('beps.plugins.nvim-cmp')
        end,
    },

}

-- Completion
return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = { "InsertEnter", "CmdlineEnter"},
        config = function ()
            require('beps.plugins.nvim-cmp')
        end,
        dependencies = {
            { 'saadparwaiz1/cmp_luasnip' },
        }
    },

    {
        'hrsh7th/cmp-cmdline',
        event = 'InsertEnter',
        dependencies = 'nvim-cmp'
    },

    {
        'hrsh7th/cmp-nvim-lsp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig'
        }
    },

    {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig'
        }
    },

    {
        'hrsh7th/cmp-path',
        event = { 'CmdlineEnter', 'InsertEnter'},
        dependencies = {
            'hrsh7th/nvim-cmp'
        }
    },

    {
        'hrsh7th/cmp-buffer',
        event = { 'CmdlineEnter', 'InsertEnter'},
        dependencies = {
            'hrsh7th/nvim-cmp'
        }
    },

    {
        'hrsh7th/cmp-nvim-lua',
        event = 'InsertEnter',
        dependencies = 'hrsh7th/nvim-cmp'

    },

    {
        'jalvesaq/cmp-nvim-r',
        ft = 'r',
        dependencies = 'hrsh7th/nvim-cmp'
    },

    {
        -- TODO:: fix event
        'rcarriga/cmp-dap',
        event = { 'CmdlineEnter', 'InsertEnter'},
        dependencies = 'hrsh7th/nvim-cmp'
    },

    {
        'onsails/lspkind-nvim',
        event = { 'CmdlineEnter', 'InsertEnter'},
        dependencies = {
            'hrsh7th/nvim-cmp'
        }
    },

    {
        'kdheepak/cmp-latex-symbols',
        event = 'InsertEnter',
        dependencies = 'hrsh7th/nvim-cmp'
    },

    {
        "saadparwaiz1/cmp_luasnip",
        event = { 'BufReadPost', 'InsertEnter' },
        dependencies = {
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
        }
    },

    {
        'L3MON4D3/LuaSnip',
        event = 'InsertCharPre',
    },

}

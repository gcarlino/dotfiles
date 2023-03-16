return {
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        -- event = "BufReadPre",
        config = function ()
            require('beps.plugins.dap')
        end,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'mfussenegger/nvim-dap-python',
            'theHamsta/nvim-dap-virtual-text' ,
            'nvim-telescope/telescope-dap.nvim' ,
        }
    },
}

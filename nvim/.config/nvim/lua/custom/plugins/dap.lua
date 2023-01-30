return {
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        -- event = "BufReadPre",
        config = function ()
            require('beps.plugins.dap')
        end,
        dependencies = {
            'mfussenegger/nvim-dap-python',
            'theHamsta/nvim-dap-virtual-text' ,
            'nvim-telescope/telescope-dap.nvim' ,
            'rcarriga/nvim-dap-ui',
        }
    },
}

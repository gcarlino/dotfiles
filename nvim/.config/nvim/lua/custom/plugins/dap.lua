return {
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        -- event = "BufReadPre",
        config = function ()
            require('beps.plugins.dap')
        end
    },
    { 'rcarriga/nvim-dap-ui', event = "VeryLazy"},
    { 'mfussenegger/nvim-dap-python', event = "VeryLazy"},
    { 'theHamsta/nvim-dap-virtual-text', event = "VeryLazy" },
    { 'nvim-telescope/telescope-dap.nvim', event = "VeryLazy" },
}

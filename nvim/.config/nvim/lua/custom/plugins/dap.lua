return {
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
        config = function ()
            require('beps.plugins.dap')
        end
    },
    { 'rcarriga/nvim-dap-ui' },
    { 'mfussenegger/nvim-dap-python' },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'nvim-telescope/telescope-dap.nvim' },
}

return {

    {
        "mfussenegger/nvim-dap",
        event = 'VeryLazy',
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            "nvim-neotest/nvim-nio",
            "nvim-telescope/telescope-dap.nvim",
            "williamboman/mason.nvim",
            -- 'rcarriga/cmp-dap',
        },
        config = function()
            require('custom.dap')
        end,
    },

}

return {
    {
        "mfussenegger/nvim-dap",
        -- event = "VeryLazy",
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require('beps.plugins.dap')
        end,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text" ,
            'nvim-telescope/telescope.nvim',
        }
    },
}

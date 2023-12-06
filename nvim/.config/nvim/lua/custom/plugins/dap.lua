return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufNewFile" },
        config = function ()
            require('beps.plugins.dap')
        end,
        dependencies = {
            'nvim-telescope/telescope.nvim',
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text" ,
        }
    },
}

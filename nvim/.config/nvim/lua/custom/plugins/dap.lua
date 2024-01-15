return {

    {
        "mfussenegger/nvim-dap",
        -- cmd = "DapContinue",
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            -- 'rcarriga/cmp-dap',
        },
        config = function()
            require('beps.plugins.dap')
        end,
    },

}

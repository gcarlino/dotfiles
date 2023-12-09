return {

    {
        "mfussenegger/nvim-dap",
        -- cmd = "DapContinue",
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-telescope/telescope-dap.nvim",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
            -- 'rcarriga/cmp-dap',
        },
        config = function()
            require('beps.plugins.dap')
        end,
    },

}

return {
    {
        "mfussenegger/nvim-dap",
        -- cmd = "DapContinue",
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('beps.plugins.dap')
        end,
        dependencies = {
            "nvim-telescope/telescope-dap.nvim",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
        }
    },

    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap"
        },
    },
}

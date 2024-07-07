return {

    {
        "mfussenegger/nvim-dap",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope-dap.nvim",
            "williamboman/mason.nvim",
            -- 'rcarriga/cmp-dap',
        },
        config = function()
            require('custom.dap')
        end,
    },

}

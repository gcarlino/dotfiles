return {

    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        keys = {
            { "<C-space>", "<cmd>FzfLua buffers<CR>", desc = "Fzf-lua buffers" },
            { "<C-p>", "<cmd>FzfLua files<CR>", desc = "Fzf-lua files" },
            { "<C-/>", "<cmd>FzfLua helptags<CR>", desc = "Fzf-lua help" },
            { "<C-\\>", "<cmd>FzfLua live_grep<CR>", desc = "Fzf-lua live_grep" },
        },
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('custom.telescope')
        end,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-file-browser.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons' },
        }
    },
}

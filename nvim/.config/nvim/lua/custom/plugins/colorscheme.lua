return {

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        cond = true,
        config = function()
            require('onedark').setup({
                style = 'dark',
                toggle_style_key = "<leader>tc",
                toggle_style_list = { 'dark', 'light' },
            })
            require('onedark').load()
        end
    },

}

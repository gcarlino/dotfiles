return {

    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        cond = true,
        config = function()
            require('onedark').setup({
                style = 'dark',
            })
            require('onedark').load()
        end
    },

}

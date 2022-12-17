-- Toggle backgournd color
vim.api.nvim_set_keymap("n", "<leader>b", "", {
    noremap = true,
    callback = function()
        local _background = vim.api.nvim_get_option("background")
        if (_background == "light") then
            vim.cmd('colorscheme nordfox')
            vim.api.nvim_set_option('background', 'dark')
        else
            vim.cmd('colorscheme dayfox')
            vim.api.nvim_set_option('background', 'light')
        end
    end,
    desc = "Toggle background color"
})

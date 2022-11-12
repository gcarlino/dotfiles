-- -- sainnhe/edge
-- vim.g.edge_style = 'aura'
-- vim.g.edge_better_performance = 1
-- vim.g.edge_dim_foreground = 1
-- vim.g.edge_disable_italic_comment = 1
-- vim.g.edge_disable_terminal_colors = 1
-- vim.cmd([[ colorscheme edge ]])
-- Override split separator color
-- vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#666666' })

-- require('onedark').setup({
--     style = "dark",
--     toggle_style_key = '<leader>ts',
--     code_style = {
--         comments = 'none',
--     }
-- })
-- require('onedark').load()


require('nightfox').setup({
    terminal_colors = false
})
vim.cmd("colorscheme nordfox")

-- Toggle backgournd color
vim.api.nvim_set_keymap("n", "<leader>b", "", {
    noremap = true,
    callback = function()
        local _background = vim.api.nvim_get_option("background")
        if (_background == "light") then
            vim.api.nvim_set_option('background', 'dark')
            vim.cmd('colorscheme nordfox')
        else
            vim.api.nvim_set_option('background', 'light')
            vim.cmd('colorscheme dayfox')
        end
    end,
    desc = "Toggle background color"
})

-- neovim configuration for macOS

-- Preview markdown with Marked.app
vim.keymap.set('n', '<leader>mk', ':!open -a "/Applications/Marked 2.app" "%"<CR>',
    { desc = "Preview with Marked app" })

-- Open Dash for documentation *** KEYMAP NOT WORKING ***
vim.keymap.set('n','<leader>ds',
    function()
        require('dash.providers.telescope').dash({ bang = false, initial_text = vim.fn.expand("<cword>") })
    end,
    { desc = "Search with Dash app." })

-- vimr
-- if vim.fn.has("gui_vimr") == 1 then
--     vim.opt.background = "light"
-- end

-- neovide
if vim.g.neovide then
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.o.guifont = "SF Monoh12"
end


-- Simularia notes
local M = {}
M.simulnotes = function()
    local opts = {
        cwd = "~/Simularia/Notes/",
        prompt_title = "~ (Not only) Simularia Notes ~",
    }
    require('telescope.builtin').live_grep(opts)
end

vim.keymap.set('n', '<leader>sn', function() M.simulnotes() end, {
    desc = "List Simularia notes with Telescope"
})

-- neovim configuration for macOS
if vim.fn.has("mac") ~= 1 then
    return
end

-- Simularia notes
local M = {}
M.simulnotes = function()
    local opts = {
        cwd = "~/Simularia/Notes/",
        prompt_title = "~ Grep (not only) Simularia Notes ~",
    }
    require('telescope.builtin').live_grep(opts)
end

M.simultitles = function()
    local opts = {
        cwd = "~/Simularia/Notes/",
        prompt_title = "~ Find files in (not only) Simularia Notes ~",
    }
    require('telescope.builtin').find_files(opts)
end

vim.keymap.set('n', '<leader>sg', function() M.simulnotes() end, {
    desc = "Grep Simularia notes with Telescope" })
vim.keymap.set('n', '<leader>sn', function() M.simultitles() end, {
    desc = "List Simularia notes with Telescope" })

-- Preview markdown with Marked.app
vim.keymap.set('n', '<leader>m', ':!open -a "/Applications/Marked 2.app" "%"<CR>',
    { desc = "Preview with Marked", silent = true })

-- Open Dash for documentation *** KEYMAP NOT WORKING ***
-- vim.keymap.set('n', '<leader>ds',
--     function()
--         require('dash.providers.telescope').dash(
--             { bang = false, initial_text = vim.fn.expand("<cword>") })
--     end,
--     { desc = "Search with Dash app." })
--
-- vimr
-- if vim.fn.has("gui_vimr") == 1 then
--     vim.opt.background = "light"
-- end

-- neovide
if vim.g.neovide then
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.o.guifont = "SF Mono:h12"
end

-- Open the current file in the default program (on Mac this should just be just `open`)
-- vim.keymap.set('n', '<leader>x', ':!open %<cr><cr>')


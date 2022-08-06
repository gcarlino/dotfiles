-- mac configuration for neovim

local keymapOpts = { noremap = true, silent = true}

-- Open Marked.app
vim.api.nvim_set_keymap('n', '<leader>mk', ':silent !open -a "Marked 2.app" %<CR>', keymapOpts)
-- Open Dash for documentation
vim.api.nvim_set_keymap('n', '<leader>D', '<Plug>DashSearch', keymapOpts)

-- Source this lua file and init.lua
vim.api.nvim_set_keymap('n', '<leader>S', ':lua package.loaded.bepsmac=nil<cr>:source $MYVIMRC<cr>',
    keymapOpts)

if vim.fn.has("gui_vimr") == 1 then
    vim.opt.background = "light"
end

-- Functions
local M = {}

-- Simularia notes
M.simulnotes = function()
    local opts = {
        cwd = "~/Simularia/Notes/",
        prompt_title = "~ (Not only) Simularia Notes ~",
    }
    require('telescope.builtin').live_grep(opts)
end

-- Simularia notes
vim.keymap.set('n', '<leader>sn', function() M.simulnotes() end, {
    desc = "List Simularia notes with Telescope"
})

-- mac configuration for neovim

local keymapOpts = { noremap = true, silent = true}

-- Open Marked.app
vim.keymap.set('n', '<leader>mk', ':silent !open -a "Marked 2.app" %<CR>', { desc = "Preview with Marked app"})

-- Open Dash for documentation *** KEYMAP NOT WORKING ***
vim.keymap.set('n', '<leader>D', function ()
  require('dash.providers.telescope').dash({bang = false, initial_text = ''})
end,
  {desc = "Search with Dash app."} )

-- Source this lua file and init.lua
vim.keymap.set('n', '<leader>S', ':lua package.loaded.beps.mac=nil<cr>:source $MYVIMRC<cr>',
    { desc = "Source beps.mac.lua and init.lua"} )

if vim.fn.has("gui_vimr") == 1 then
    vim.opt.background = "light"
end

if vim.g.neovide then
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.o.guifont="SF Mono:h12"
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

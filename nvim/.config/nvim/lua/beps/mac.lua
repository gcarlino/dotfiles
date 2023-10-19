-- neovim configuration for macOS

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
vim.keymap.set('n', '<leader>sf', function() M.simultitles() end, {
    desc = "List Simularia notes with Telescope" })

-- Preview markdown with Marked.app
vim.keymap.set('n', '<leader>mk', ':!open -a "/Applications/Marked 2.app" "%"<CR>',
    { desc = "Preview with Marked app", silent = true })

-- Open Dash for documentation *** KEYMAP NOT WORKING ***
vim.keymap.set('n','<leader>ds',
    function() require('dash.providers.telescope').dash(
            { bang = false, initial_text = vim.fn.expand("<cword>") })
    end,
    { desc = "Search with Dash app." })
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


-- Obsidian
-- vim.keymap.set("n", "gf", function()
--   if require("obsidian").util.cursor_on_markdown_link() then
--     return "<cmd>ObsidianFollowLink<CR>"
--   else
--     return "gf"
--   end
-- end, { noremap = false, expr = true })
--
-- vim.keymap.set('n', '<leader>oo', ":ObsidianOpen<CR>", {desc = "Obsidian: open a note in the Obsidian app."})
-- vim.keymap.set('n', '<leader>on', ":ObsidianNew<CR>", {desc = "Obsidian: create a new."})
-- vim.keymap.set('n', '<leader>oq', ":ObsidianQuickSwitch<CR>", {desc = "Obsidian: quickly switch to another note in the vault."})
-- vim.keymap.set('n', '<leader>of', ":ObsidianFollowLink<CR>", {desc = "Obsidian: follow a note reference."})
-- vim.keymap.set('n', '<leader>ob', ":ObsidianBacklinks<CR>", {desc = "Obsidian: get a location list of references to the current buffer."})
-- vim.keymap.set('n', '<leader>os', ":ObsidianSearch<CR>", {desc = "Obsidian: search for notes in your vault."})
-- vim.keymap.set('n', '<leader>ol', ":ObsidianLink<CR>", {desc = "Obsidian: link an in-line visual selection of text to a note."})
-- vim.keymap.set('n', '<leader>oc', ":ObsidianLinkNew<CR>", {desc = "Obsidian: create a new note and link it to an in-line visual selection of text."})

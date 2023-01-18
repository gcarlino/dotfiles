local status, telescope = pcall(require, 'telescope')
if not status then
    print('Telescope is not available.')
    return
end

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<M-v>'] = require('telescope.actions.layout').toggle_preview
            }
        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        layout_strategies = 'flex',
        layout_config = {
            prompt_position = 'top',
        },
    },
    pickers = {
        -- find_files = {
        --     theme = "ivy",
        -- },
        buffers = {
            -- ignore_current_buffer = true,
            sort_mru = true,
            mappings = {
                i = { ["<c-d>"] = require("telescope.actions").delete_buffer, },
                n = { ["<c-d>"] = require("telescope.actions").delete_buffer, },
            },
        },
    },
    preview = {
        hide_on_startup = false
    },
    extensions = {
        file_browser = {
            respect_gitignore = false,
            hidden = true,
        },
        undo = {
            use_delta = true,
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.5,
            },
        },
        dash = { },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown()
        },
    }
}

-- Load extensions
require('telescope').load_extension 'file_browser'
require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")
-- require('telescope').load_extension('dap')
require('telescope').load_extension('undo')

-- Keymaps
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p',
    function() builtin.commands() end,
    { desc = " lists plugin/commands and runs them on `<cr>`" }
)

vim.keymap.set('n', '<leader><space>',
    function() builtin.buffers() end,
    { desc = " show buffers" }
)

vim.keymap.set('n', '<leader>fs',
    function() require('telescope').extensions.file_browser.file_browser() end,
    { desc = " file browser" }
)

vim.keymap.set('n', '<leader>ff',
    function() builtin.find_files() end,
    { desc = " find files" }
)

vim.keymap.set('n', '<leader>fb',
    function() builtin.current_buffer_fuzzy_find() end,
    { desc = " fuzzy find in current buffer" }
)

vim.keymap.set('n', '<leader>fh',
    function() builtin.help_tags() end,
    { desc = " find help" }
)

vim.keymap.set('n', '<leader>fw',
    function() builtin.grep_string() end,
    { desc = " searches for string under your cursor in your current working directory" }
)

vim.keymap.set('n', '<leader>fg',
    function() builtin.live_grep() end,
    { desc = " search for a string and get results live as you type." }
)

vim.keymap.set('n', '<leader>fk',
    function() builtin.keymaps() end,
    { desc = " seaarch keymaps" }
)

vim.keymap.set('n', '<leader>fo',
    function() builtin.oldfiles() end,
    { desc = " see recently opened/edited files" }
)

vim.keymap.set('n', '<leader>fu',
    function () require('telescope').extensions.undo.undo() end,
    { desc = " see undo tree" }
)

-- Telescope for git
vim.keymap.set('n', '<leader>gc',
    function() builtin.git_commits() end,
    { desc = " lists commits for current directory with diff preview" }
)

vim.keymap.set('n', '<leader>gs',
    function() builtin.git_status() end,
    { desc = " lists git status for current directory" }
)

vim.keymap.set('n', '<leader>gb',
    function() builtin.git_bcommits() end,
    { desc = " lists commits for current buffer with diff preview" }
)

-- Search for dotfiles
vim.keymap.set('n', '<leader>ed',
    function()
        builtin.git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Edit dotfiles ~",
            layout_strategies = "horizontal",
        }
    end,
    { desc = " edit dotfiles" }
)


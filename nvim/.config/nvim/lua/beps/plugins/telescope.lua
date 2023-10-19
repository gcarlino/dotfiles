local status, telescope = pcall(require, 'telescope')
if not status then
    print('Telescope is not available.')
    return
end

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<M-v>'] = require('telescope.actions.layout').toggle_preview,
                ["<M-t>"] = trouble.open_with_trouble,
            },
            n = {
                ["<M-t>"] = trouble.open_with_trouble,
            }
        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        layout_strategies = 'flex',
        layout_config = {
            prompt_position = 'top',
            preview_width = 0.5
        },
    },
    pickers = {
        buffers = {
            -- ignore_current_buffer = true,
            sort_mru = true,
            mappings = {
                i = { ["<c-b>"] = actions.delete_buffer, },
                n = { ["<c-b>"] = actions.delete_buffer, },
            },
        },
        find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
    preview = {
        hide_on_startup = false
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            respect_gitignore = false,
            hidden = true,
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


-- Keymaps
local builtin = require('telescope.builtin')

-- Reopen last used telescope window keeping focus to current buffer
vim.keymap.set("n", ";",
    "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>",
    { desc = " Resume telescope" })

vim.keymap.set('n', '<leader>p', function() builtin.commands() end,
    { desc = " lists plugin/commands and runs them on `<cr>`" }
)

vim.keymap.set('n', '<leader><space>', function() builtin.buffers() end,
    { desc = " show buffers" }
)

vim.keymap.set('n', '<leader>fs',
    function() require('telescope').extensions.file_browser.file_browser() end,
    { desc = " file browser" }
)

vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end,
    { desc = " find files" }
)

vim.keymap.set('n', '<leader>fb', function() builtin.current_buffer_fuzzy_find() end,
    { desc = " fuzzy find in current buffer" }
)

vim.keymap.set('n', '<leader>fh', function() builtin.help_tags() end,
    { desc = " find help" }
)

vim.keymap.set('n', '<leader>fw', function() builtin.grep_string() end,
    { desc = " searches for string under your cursor in your current working directory" }
)

vim.keymap.set('n', '<leader>fg', function() builtin.live_grep() end,
    { desc = " search for a string and get results live as you type." }
)

vim.keymap.set('n', '<leader>fk', function() builtin.keymaps() end,
    { desc = " seaarch keymaps" }
)

vim.keymap.set('n', '<leader>fo', function() builtin.oldfiles() end,
    { desc = " see recently opened/edited files" }
)

-- Telescope for git
vim.keymap.set('n', '<leader>gc', function() builtin.git_commits() end,
    { desc = " lists commits for current directory with diff preview" }
)

vim.keymap.set('n', '<leader>gs', function() builtin.git_status() end,
    { desc = " lists git status for current directory" }
)

vim.keymap.set('n', '<leader>gb', function() builtin.git_bcommits() end,
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

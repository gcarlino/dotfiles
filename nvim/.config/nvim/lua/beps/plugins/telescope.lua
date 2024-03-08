local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<M-v>"] = require('telescope.actions.layout').toggle_preview,
                ["<M-t>"] = trouble.open_with_trouble,
                -- ["<C-h>"] = "which_key",
            },
            n = {
                ["<M-v>"] = require('telescope.actions.layout').toggle_preview,
                ["<M-t>"] = trouble.open_with_trouble,
            }
        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        layout_strategies = 'flex',
        layout_config = {
            prompt_position = 'top',
            -- preview_width = 0.5
        },
        dynamic_preview_title = true,
        file_ignore_patterns = { "^.git/" },
        -- vimgrep_arguments = {
        --     "rg",
        --     "--color=never",
        --     "--no-heading",
        --     "--with-filename",
        --     "--line-number",
        --     "--column",
        --     "--smart-case",
        --     "--iglob !**/.git/*"
        -- }
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
            -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            no_ignore = true,
            hidden = true,
        },
        live_grep = {
            no_ignore = true,
            hidden = true,
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            respect_gitignore = false,
            hidden = true,
        },
        -- dash = {},
        ["ui-select"] = {
            require("telescope.themes").get_dropdown()
        },
    }
}

-- Load extensions
telescope.load_extension('fzf')
telescope.load_extension 'file_browser'
telescope.load_extension("ui-select")
-- telescope.load_extension("dap")

-- Keymaps
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p', builtin.commands,
    { desc = " lists plugin/commands and runs them on `<cr>`" })

vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = " show buffers" })

vim.keymap.set('n', '<leader>fs',
    function() require('telescope').extensions.file_browser.file_browser() end,
    { desc = " file browser" })

vim.keymap.set('n', '<leader>fg', builtin.live_grep,
    { desc = " search for a string and get results live as you type." })

vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume'})

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = " find files" })

vim.keymap.set('n', '<leader>/', function ()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
    end, { desc = " [/] fuzzy find in current buffer" })

vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = " [F]ind [H]elp" })

vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = "[F]ind [Select] Telescope" })

vim.keymap.set('n', '<leader>fw', builtin.grep_string,
    { desc = " searches for string under your cursor in your current working directory" })

vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = " seaarch keymaps" })

vim.keymap.set('n', '<leader>fo', builtin.oldfiles,
    { desc = " see recently opened/edited files" })

-- Telescope for git
vim.keymap.set('n', '<leader>gc', builtin.git_commits,
    { desc = " lists commits for current directory with diff preview" })

vim.keymap.set('n', '<leader>gs', builtin.git_status,
    { desc = " lists git status for current directory" })

vim.keymap.set('n', '<leader>gb', builtin.git_bcommits,
    { desc = " lists commits for current buffer with d--[[  ]]iff preview" })

-- Search for dotfiles
vim.keymap.set('n', '<leader>fd',
    function()
        builtin.git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Edit dotfiles ~",
            layout_strategies = "horizontal",
        }
    end,
    { desc = " edit dotfiles" }
)

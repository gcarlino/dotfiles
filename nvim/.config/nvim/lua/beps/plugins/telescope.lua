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
    preview = {
        hide_on_startup = false
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown()
        },
        file_browser = {
            respect_gitignore = false,
            hijack_netrw = true,
        },
    }
}

if vim.fn.has('mac') == 1 then
    require('telescope').setup {
        extensions = {
            dash = {
                file_type_keywords = {
                    html = { 'html', 'css', 'javascript', 'bootstrap' }
                }
            }
        }
    }

    require('telescope').load_extension('dash')
end

-- Load extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension 'file_browser'
require("telescope").load_extension("packer")
require("telescope").load_extension("ui-select")
require('telescope').load_extension('dap')

-- Keymaps
vim.keymap.set('n', '<leader>p', function() require('telescope.builtin').commands() end, {
    desc = "Lists available plugin/user commands and runs them on `<cr>`"
})

vim.keymap.set('n', '<leader><space>', function() require('telescope.builtin').buffers() end, {
    desc = "Show buffers with Telescope"
})

vim.keymap.set('n', '<leader>fs', function() require('telescope').extensions.file_browser.file_browser() end, {
    desc = "Telescope file browser"
})

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, {
    desc = "Telescope find files"
})

vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').current_buffer_fuzzy_find() end, {
    desc = "Telescope fuzzy find in current buffer"
})

vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, {
    desc = "Telescope help"
})

vim.keymap.set('n', '<leader>fw', function() require('telescope.builtin').grep_string() end, {
    desc = "Telescope searches for the string under your cursor in your current working directory"
})

vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, {
    desc = "Search for a string and get results live as you type."
})

vim.keymap.set('n', '<leader>fk', function() require('telescope.builtin').keymaps() end, {
    desc = "See keymaps with Telescope"
})

vim.keymap.set('n', '<leader>fo', function() require('telescope.builtin').oldfiles() end, {
    desc = "See recently opened/edited files with Telescope"
})

vim.keymap.set('n', '<leader>?', '<CMD>Cheatsheet<CR>', { desc = "Cheatsheet" })

-- Telescope for git
vim.keymap.set('n', '<leader>gc', function() require('telescope.builtin').git_commits() end, {
    desc = "Telescope lists commits for current directory with diff preview"
})

vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end, {
    desc = "Telescope lists git status for current directory"
})

vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_bcommits() end, {
    desc = "Telescope lists commits for current buffer with diff preview"
})

-- Search dotfiles
vim.keymap.set('n', '<leader>ed',
    function()
        require('telescope.builtin').git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Edit dotfiles ~",
            layout_strategies = "horizontal",
        }
    end,
    { desc = "Telescope edit dotfiles" })

-- Telescope LSP commands
vim.keymap.set('n', '<leader>ls', function() require('telescope.builtin').lsp_references() end, {
    desc = "List LSP references for word under the cursor"
})
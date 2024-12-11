local telescope = require("telescope")
local trouble = require("trouble.sources.telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<M-v>"] = require('telescope.actions.layout').toggle_preview,
                ["<M-t>"] = trouble.open,
            },
            n = {
                ["<M-v>"] = require('telescope.actions.layout').toggle_preview,
                ["<M-t>"] = trouble.open,
            }
        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        layout_strategies = 'flex',
        layout_config = {
            prompt_position = 'top',
        },
        dynamic_preview_title = true,
        file_ignore_patterns = { '^.git/', '/.git/', 'lazy-lock.json', '.DS_Store' },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!**/.git/*",
            "--glob=!lazy-lock.json"
        },
    },
    pickers = {
        find_files = {
            no_ignore = true,
            hidden = true,
        },
        live_grep = {
            no_ignore = true,
            hidden = true,
        }
    },
    extensions = {
        fzf = {},
        file_browser = {
            hijack_netrw = true,
            respect_gitignore = false,
            hidden = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown()
        },
    }
}

-- Load extensions
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension("ui-select")

-- Keymaps
local builtin = require('telescope.builtin')

-- vim.keymap.set('n', '<leader>fp', builtin.commands,
--     { desc = "[f]ind [p]lugin/commands" })

vim.keymap.set('n', '<leader><space>', builtin.buffers,
    { desc = "find in open buffers" })

vim.keymap.set('n', '<leader>fs',
    function() require('telescope').extensions.file_browser.file_browser() end,
    { desc = "[f]ile [s]earch in browser" })

vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "[f]ind by [g]rep." })

vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "[f]ind [r]esume" })

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[f]ind [f]iles" })

vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
    })
end, { desc = "[/] fuzzy find in current buffer" })

vim.keymap.set("n", "<leader>f/", function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end, { desc = "[/] find in open files" })

vim.keymap.set('n', '<leader>fh', function ()
    builtin.help_tags{
        layout_strategy = 'vertical',
        layout_config = {
            mirror = true,
            width = 120,
        },
    }
end , { desc = "[f]ind [h]elp" })

vim.keymap.set('n', '<leader>fw', builtin.grep_string,
    { desc = "[f]ind [w]ord under cursor in working directory" })

vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "[f]ind [k]eymaps" })

-- Find dotfiles
vim.keymap.set('n', '<leader>fd',
    function()
        builtin.git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Find dotfiles ~",
            layout_strategies = "horizontal",
        }
    end,
    { desc = "[f]ind [d]otfiles" }
)

-- Find plugins
vim.keymap.set("n", "<leader>fp", function ()
    builtin.find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
        prompt_title = "~ Find plugins ~",
    }
end,
    { desc = "[f]ind [p]lugins" }
)

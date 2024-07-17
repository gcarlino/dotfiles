local telescope = require("telescope")
local actions = require("telescope.actions")
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
        layout_config = { prompt_position = 'top', },
        dynamic_preview_title = true,
        file_ignore_patterns = { '^.git/' },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!**/.git/*"  -- It does not seem working
        }
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
local set = vim.keymap.set

set('n', '<leader>fp', builtin.commands,
    { desc = "[f]ind [p]lugin/commands" })

set('n', '<leader><space>', builtin.buffers,
    { desc = "find in open buffers" })

set('n', '<leader>fs',
    function() require('telescope').extensions.file_browser.file_browser() end,
    { desc = "[f]ile [s]earch in browser" })

set('n', '<leader>fg', builtin.live_grep, { desc = "[f]ind by [g]rep." })

set('n', '<leader>fr', builtin.resume, { desc = "[f]ind [r]esume"})

set('n', '<leader>ff', builtin.find_files, { desc = "[f]ind [f]iles" })

set('n', '<leader>/', function ()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        -- winblend = 10,
        previewer = false,
    })
    end, { desc = "[/] fuzzy find in current buffer" })

set("n", "<leader>f/", function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
    end, { desc = "[/] find in open files" })

set('n', '<leader>fh', builtin.help_tags, { desc = "[f]ind [h]elp" })

set('n', '<leader>ft', builtin.builtin, { desc = "[f]ind builtin [t]elescope" })

set('n', '<leader>fw', builtin.grep_string,
    { desc = "[f]ind [w]ord under cursor in working directory" })

set('n', '<leader>fk', builtin.keymaps, { desc = "[f]ind [k]eymaps" })

set('n', '<leader>fo', builtin.oldfiles,
    { desc = "[f]ind recently [o]pened/edited files" })

-- -- Telescope for git
-- vim.keymap.set('n', '<leader>gc', builtin.git_commits,
--     { desc = " lists commits for current directory with diff preview" })
--
-- vim.keymap.set('n', '<leader>gs', builtin.git_status,
--     { desc = " lists git status for current directory" })
--
-- vim.keymap.set('n', '<leader>gb', builtin.git_bcommits,
--     { desc = " lists commits for current buffer with d--[[  ]]iff preview" })

-- Search for dotfiles
set('n', '<leader>fd',
    function()
        builtin.git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Edit dotfiles ~",
            layout_strategies = "horizontal",
        }
    end,
    { desc = "[f]ind [d]otfiles" }
)

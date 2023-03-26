local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
    print('Treesitter is not available.')
    return
end

-- Parsers must be installed manually via :TSInstall
treesitter.setup({
    ensure_installed = {
        'help', 'json', 'yaml', 'toml', 'html', 'css',
        'markdown', 'markdown_inline', 'latex',
        'lua', 'vim', 'dockerfile', 'python', 'fortran', 'c', 'r', 'cmake', 'bash', 'diff',
        'cuda', 'regex'
    },
    sync_install = false,
    auto_install = true,
    additional_vim_regex_highlighting = false,
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
})

-- Tree-sitter base folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.cmd('set nofoldenable')
--
-- -- Open all folds
-- vim.api.nvim_create_autocmd(
--     {"BufReadPost", "FileReadPost", "FilterReadPost"},
--     {
--         pattern = '*',
--         command = "normal zR"
--     }
-- )

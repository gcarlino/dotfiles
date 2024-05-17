local status, treesitterConfigs = pcall(require, 'nvim-treesitter.configs')
if not status then
    print('Treesitter is not available.')
    return
end

-- Parsers must be installed manually via :TSInstall
---@diagnostic disable: missing-fields
treesitterConfigs.setup({
    ensure_installed = {
        "vim", "vimdoc",
        "json", "yaml", "toml",
        "html", "css",
        "markdown", "markdown_inline", "latex",
        "lua", "python", "fortran", "c", "r",
        "cmake", "bash", "diff", "regex"
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
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

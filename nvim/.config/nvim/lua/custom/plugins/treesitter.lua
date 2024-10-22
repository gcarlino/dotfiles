return {
    {
        'nvim-treesitter/nvim-treesitter',
        -- version = false,
        event = 'VeryLazy',
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "vim", "vimdoc", "json", "yaml", "toml",
                "html", "css",
                "markdown", "markdown_inline", "latex",
                "lua", "luadoc",
                "python", "c", "r", "rnoweb",
                "cmake", "bash", "diff", "regex"
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                -- additional_vim_regex_highlighting = { 'fortran' },
            },
            indent = {
                enable = true,
                disable = { 'r', 'fortran' }
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "gnn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                }
            },
            textobjects = { enable = true },

            -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
            -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        },
    },
}

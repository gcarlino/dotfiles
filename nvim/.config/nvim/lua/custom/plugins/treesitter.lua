return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "vim", "vimdoc", "json", "yaml", "toml",
                    "html", "css",
                    "markdown", "markdown_inline", "latex",
                    "lua", "python", "c", "r",
                    "cmake", "bash", "diff", "regex"
                },
                sync_install = false,
                auto_install = true,
                ignore_install = { },
                -- ignore_install = { "fortran" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = { "fortran" }
                },
                indent = {
                    enable = true,
                    -- disable = { "fortran" }
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    }
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
                modules = { },
            })

            -- Folding
            vim.o.foldmethod = "expr"
            vim.o.foldexpr = "nvim_treesitter#foldexpr()"

        end,
    },
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        event = "VeryLazy",
        -- event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        build = ":TSUpdate",
        config = function ()
            -- require('beps.plugins.treesitter')
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "vim", "vimdoc", "json", "yaml", "toml",
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
                indent = { enable = true },
            })
        end,
    },
}

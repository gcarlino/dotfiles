-- Usiamo mason per rendere l'installazione semplice su tutte le piattaforme.
--
-- LSP
--   R         install.packages("languageserver")
--   Python:   pip install pyplsp
--   Fortran:  pip install -U fortran-language-server
--   HTML      npm install -g vscode-langservers-extracted (NO)
--   YAML      brew install yaml-language-server (NO)
--   BASH      brew install bash-language-server (NO)
--   LUA       brew install lua-language-server
--   LATEX     brew install texlab
--   cmake     pip3 install cmake-language-server
--   clangd    apt install clangd
--   markdown: marksman

return {

    -- LSP Plugins
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },

    {
        'Bilal2453/luvit-meta',
        lazy = true,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
			{ "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim", opts = {} },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("custom.lsp")
        end,
    },

    -- Currently disabled since python linters are managed by pylsp
    {
        "mfussenegger/nvim-lint",
        enabled = false,
        config = function()
            local lint = require("lint")
            -- lint.linters_by_ft = {
            --     html = { 'tidy' }
            -- }
            -- lint on save
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end
    },

    {
        'mhartington/formatter.nvim',
        enabled = false,
        keys = {
            { "<leader>F", "<cmd>Format<cr>", desc = "Format" },
        },
        config = function()
            require('formatter').setup({
                filetype = {
                    python = {
                        require("formatter.filetypes.python").black
                    },
                    lua = {
                        require("formatter.filetypes.lua").stylua
                    },
                    toml = {
                        require("formatter.filetypes.toml").taplo()
                    },
                }
            })
        end
    },
}

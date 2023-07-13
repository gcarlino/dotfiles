-- LSP
-- Installati a mano i server di:
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
--
-- Usiamo mason per rendere l'installazione semplice su tutte le piattaforme.
--
return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('beps.plugins.lsp')
        end,
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        }
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        cmd = "Mason",
    },

    {
        "williamboman/mason-lspconfig.nvim",
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

    {
        'glepnir/lspsaga.nvim',
        branch = 'main',
        event = { "BufReadPre", "BufNewFile" },
        -- event = "BufRead",
        enabled = false,
        config = function()
            require('beps.plugins.lsp')
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-treesitter/nvim-treesitter',
        }

    },
}

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
return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('beps.plugins.lsp')
        end,
        -- dependencies = {
        -- }
        --
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

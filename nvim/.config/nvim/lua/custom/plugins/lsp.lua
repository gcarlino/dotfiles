-- We use mason to simplify server installation on all platforms
--
-- LSP (old stuff
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
        "neovim/nvim-lspconfig",
        dependencies = {
			{ "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            { 'saghen/blink.cmp' },
			{ "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            require("custom.lsp")
        end,
    },
}

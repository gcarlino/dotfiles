-- Install packer
-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--     Packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
--         install_path })
-- end

require('packer').startup({ function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Impatient to improve startup time
    use 'lewis6991/impatient.nvim'

    use { 'nvim-lua/plenary.nvim' }

    -- Tree-sitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use { 'nvim-treesitter/playground', opt = true, cmd = 'TSPlaygroundToggle' }
    use 'nvim-treesitter/nvim-treesitter-context'

    -- LSP
    -- Installati a mano i server di:
    --   R         install.packages("languageserver")
    --   Python:   pip install pyplsp
    --   Fortran:  pip install -U fortran-language-server
    --   HTML      npm install -g vscode-langservers-extracted (NO)
    --   YAML      brew install yaml-language-server (NO)
    --   BASH      brew install bash-language-server (NO)
    --   LUA       brew install lua-language-server
    --   LATEX     brew install texlab (NO)
    --   cmake     pip3 install cmake-language-server
    --   clangd    apt install clangd
    --   markdown: marksman
    use({ 'glepnir/lspsaga.nvim', branch = 'main' })
    use { 'onsails/lspkind-nvim' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    -- Standalone UI for nvim-lsp progress
    use 'j-hui/fidget.nvim'

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-nvim-lsp'},
            { 'hrsh7th/cmp-nvim-lua'},
            { 'hrsh7th/cmp-nvim-lsp-signature-help'},
            { 'hrsh7th/cmp-cmdline'},
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'kdheepak/cmp-latex-symbols' },
            'rcarriga/cmp-dap',
        },
    }

    -- Snippet
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Telescope
    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    use { 'kyazdani42/nvim-tree.lua' }
    use { 'nvim-telescope/telescope-packer.nvim' }
    use { 'sudormrfbin/cheatsheet.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope.nvim' },
        }
    }

    -- Statusline & tabline
    use { 'alvarosevilla95/luatab.nvim', requires = 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }

    -- Folding
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    -- Git
    use { 'tpope/vim-fugitive' }
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- R
    use { 'jalvesaq/Nvim-R',
        ft = 'r'
    }

    -- Debug
    use { 'mfussenegger/nvim-dap' }
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use { 'mfussenegger/nvim-dap-python', requires = { 'mfussenegger/nvim-dap' } }
    use { 'theHamsta/nvim-dap-virtual-text', requires = { 'mfussenegger/nvim-dap' } }
    use { 'nvim-telescope/telescope-dap.nvim', requires = { 'mfussenegger/nvim-dap' } }

    -- Colorschemes
    use { 'https://github.com/sainnhe/edge', disable = true }
    use { 'navarasu/onedark.nvim', disable = true }
    use { 'EdenEast/nightfox.nvim' }

    -- Comment
    use 'numToStr/Comment.nvim'

    -- Various
    -- use 'rcarriga/nvim-notify'
    use 'joeytwiddle/sexy_scroller.vim'
    use 'windwp/nvim-autopairs'
    use 'chentoast/marks.nvim'
    use { 'akinsho/toggleterm.nvim', tag = 'v2.*' }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mechatroner/rainbow_csv'
    use { 'kylechui/nvim-surround' }
    -- use 'https://github.com/godlygeek/tabular'

    -- Mac specific
    if vim.fn.has('mac') == 1 then
        use({ 'mrjones2014/dash.nvim',
            requires = { 'nvim-telescope/telescope.nvim' },
            run = 'make install', })
    end

    -- if Packer_bootstrap then
    --     require('packer').sync()
    -- end

end,
    -- Floating window for packer
    -- config = {
    --     display = {
    --         open_fn = function ()
    --             return require('packer.util').float({border = 'single'})
    --         end
    --     }
    -- }
})

-- local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     command = 'source <afile> | PackerCompile',
--     group = packer_group,
--     pattern = 'init.lua'
-- })
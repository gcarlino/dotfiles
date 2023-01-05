local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile | LuaCacheClear ',
})

-- lewis6991/impatient.nvim 
require('impatient')

return require('packer').startup({ function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Impatient to improve startup time
    use 'lewis6991/impatient.nvim'

    -- Tree-sitter
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                after = 'nvim-treesitter'
            },
            { 'nvim-treesitter/playground',
                opt = true,
                cmd = 'TSPlaygroundToggle'
            },
        },
        config = function ()
            require('beps.plugins.treesitter')
        end
    })

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
    use({ 'onsails/lspkind-nvim' })

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        requires = {
            {
                'L3MON4D3/LuaSnip',
                event = 'InsertEnter',
                after = 'nvim-cmp',
                requires = { 'rafamadriz/friendly-snippets' }
            },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            { 'kdheepak/cmp-latex-symbols', after= 'nvim-cmp' },
            { 'rcarriga/cmp-dap', after = 'nvim-cmp' },
        },
        config = function ()
            require('beps.plugins.nvim-cmp')
        end
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        event = 'CursorHold',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'nvim-telescope/telescope-file-browser.nvim' }
        },
        config = function()
            require('beps.plugins.telescope')
        end,
    }

    use({
        'kyazdani42/nvim-tree.lua',
        event = 'CursorHold',
        config = function()
            require('nvim-tree').setup({
                hijack_netrw = false,
                git = {
                    ignore = false
                }
            })
        end,
    })

    -- Statusline & tabline
    use({
        'alvarosevilla95/luatab.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require("luatab").setup({
                separator = function() return '' end,
                modified = function() return '' end,
            })
        end
    })

    use({
        'nvim-lualine/lualine.nvim',
        event = 'BufEnter',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('beps.plugins.lualine')
        end
    })

    -- Folding
    use({
        'kevinhwang91/nvim-ufo',
        event = 'BufRead',
        requires = 'kevinhwang91/promise-async',
        config = function ()
            require('beps.plugins.nvim-ufo')
        end,
        disable = true
    })

    -- Git
    use({
        'tpope/vim-fugitive',
        cmd = 'G',
    })
    use({
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function ()
            require('beps.plugins.gitsigns')
        end
    })
    use({
        'sindrets/diffview.nvim',
        event = 'BufRead',
        requires = 'nvim-lua/plenary.nvim',
        config = function ()
            require('beps.plugins.diffview')
        end
    })

    -- R
    use {
        'jalvesaq/Nvim-R',
        ft = 'r',
        config = function()
            vim.cmd([[
                let R_assign_map = '<M-->'
                let rout_follow_colorscheme = 1
                let r_syntax_folding = 1
                set nofoldenable
                autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
            ]])
        end,
        opt = true,
    }

    -- Debug
    use({
        'mfussenegger/nvim-dap',
        event = 'BufRead',
        requires = {
            { 'rcarriga/nvim-dap-ui' },
            { 'mfussenegger/nvim-dap-python' },
            { 'theHamsta/nvim-dap-virtual-text' },
            { 'nvim-telescope/telescope-dap.nvim' },
        },
        config = function ()
            require('beps.plugins.dap')
        end
    })

    -- Colorschemes
    use { 'https;//github.com/sainnhe/edge', disable = true }
    use { 'navarasu/onedark.nvim', disable = true }
    use({
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup({
                terminal_colors = false
            })
            vim.cmd.colorscheme('nordfox')
        end
    })

    -- Comment
    use({
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            require('Comment').setup()
        end
    })

    -- Various
    -- use 'rcarriga/nvim-notify'
    use({
        'mbbill/undotree',
        event = 'BufRead',
        config = function ()
            require('beps.plugins.undotree')
        end
    })
    use({ 'joeytwiddle/sexy_scroller.vim' })
    use({
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    })
    use({
        'chentoast/marks.nvim',
        config = function()
            require('marks').setup()
        end
    })
    use({
        'akinsho/toggleterm.nvim',
        tag = 'v2.*',
        event = 'CursorHold',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<c-q>]],
            }
        end
    })
    use({
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup()
        end,
    })
    use 'mechatroner/rainbow_csv'
    use({
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    })

    -- use 'https;//github.com/godlygeek/tabular'

    -- Lua
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                window = {
                    border = 'single'
                },
                disable = {
                    buftypes = {},
                    filetypes = { "TelescopePrompt" },
                },
            }
        end
    }

    -- Mac specific
    if vim.fn.has('mac') == 1 then
        use({ 'mrjones2014/dash.nvim',
            opt = true,
            -- requires = { 'nvim-telescope/telescope.nvim' },
            run = 'make install', })
    end

    if packer_bootstrap then
        require('packer').sync()
    end
end,

config = {
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single'})
        end
    }
}
})

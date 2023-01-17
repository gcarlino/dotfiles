return {
    { 'nvim-lua/plenary.nvim', lazy = true },

    {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                hijack_netrw = false,
                git = {
                    ignore = false
                }
            })
        end,
    },

    -- R
    {
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
    },


    -- Various
    { 'mbbill/undotree', },
    { 'joeytwiddle/sexy_scroller.vim', },
    { 'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    },
    {
        'chentoast/marks.nvim',
        config = function()
            require('marks').setup()
        end,
        enable = false
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<c-q>]],
            }
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup()
        end,
    },
    { 'mechatroner/rainbow_csv', },
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end
    },

}

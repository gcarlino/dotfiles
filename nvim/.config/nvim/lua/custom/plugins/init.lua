return {
    { 'nvim-lua/plenary.nvim', lazy = true },

    {
        'kyazdani42/nvim-tree.lua',
        keys = {
            {'<leader>n', ':NvimTreeToggle<CR>', desc = "Toggle nvim-tree" }
        },
        config = function()
            require('nvim-tree').setup({
                hijack_netrw = false,
                git = {
                    ignore = false
                }
            })
        end,
    },

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

    { 'lervag/vimtex' },

    -- Various
    {
        'mbbill/undotree',
        event = "VeryLazy"
    },

    {
        'joeytwiddle/sexy_scroller.vim',
        event = "BufReadPre",
    },

    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        config = function()
            require('marks').setup()
        end,
    },

    {
        'akinsho/toggleterm.nvim',
        event = 'VeryLazy',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<c-q>]],
            }
        end
    },

    {
        'mechatroner/rainbow_csv',
        event = "VeryLazy",
    },

    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup()
        end
    },
}

return {
    { 'nvim-lua/plenary.nvim', lazy = true },

    {
        'kevinhwang91/nvim-ufo',
        event = "BufRead",
        dependencies = {
            { 'kevinhwang91/promise-async' },
            {
                'luukvbaal/statuscol.nvim',
                config = function()
                    local builtin = require("statuscol.builtin")
                    require("statuscol").setup(
                    {
                        relculright = true,
                        segments = {
                            {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
                            {text = {"%s"}, click = "v:lua.ScSa"},
                            {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
                        }
                    }
                    )
                end
            },
        },
        config = function ()
            -- Fold options
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
            vim.o.foldcolumn = "1" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require("ufo").setup()
        end
    },

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

                " For radian
                let R_app = "radian"
                let R_cmd = "R"
                let R_hl_term = 0
                let R_args = ['--no-save']
                let R_bracketed_paste = 1

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
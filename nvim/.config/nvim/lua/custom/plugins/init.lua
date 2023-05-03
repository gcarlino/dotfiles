return {
    { 'nvim-lua/plenary.nvim', lazy = true },

    {
        'folke/trouble.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function ()
           require('trouble').setup({})
           vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>",
           {silent = true, noremap = true}
           )
           vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
           {silent = true, noremap = true}
           )
           vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
           {silent = true, noremap = true}
           )
           vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
           {silent = true, noremap = true}
           )
           vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
           {silent = true, noremap = true}
           )
           vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
           {silent = true, noremap = true}
           )
       end,
   },

    {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
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
        event = { "BufReadPost" },
        keys = { {"<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree"}}
    },

    {
        'windwp/nvim-autopairs',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    {
        'akinsho/toggleterm.nvim',
        event = 'VeryLazy',
        config = function()
            require('toggleterm').setup {
                open_mapping = [[<c-q>]],
            }
            -- disable spell checking in terminal
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "term://*",
                callback = function () vim.o.spell = false end
            })
        end
    },

    {
        'mechatroner/rainbow_csv',
        event = 'VeryLazy'
    },

    {
        'kylechui/nvim-surround',
        event = "VeryLazy",
        config = function()
            require('nvim-surround').setup({})
        end
    },
}

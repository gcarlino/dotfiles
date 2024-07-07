return {

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        -- event = "VimEnter",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
        -- opts = {
        --     window = {
        --         border = "single",
        --     },
        --     disable = {
        --         buftypes = {},
        --         filetypes = {},
        --     },
        -- },
        config = function ()
            require('which-key').setup()

			-- Document existing key chains
			require("which-key").register({
                ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]AP", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>l"] = { name = "[L]SP", _ = "which_key_ignore" },
				["<leader>x"] = { name = "Trouble", _ = "which_key_ignore" },
				["<leader>v"] = { name = "Diff[V]iew", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
				["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
				["<leader>o"] = { name = "[O]bsidian", _ = "which_key_ignore" },
			})
			-- visual mode
			require("which-key").register({
				["<leader>h"] = { "Git [H]unk" },
			}, { mode = "v" })
        end

    },

    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('custom.lualine')
        end,
    },

    {
        "akinsho/bufferline.nvim",
        event = "TabNew",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- keys = {
        --     { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
        --     { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        -- },
        opts = {
            options = {
                mode = "tabs",
                show_buffer_close_icons = false,
                show_close_icon = false,
                always_show_bufferline = false,
                separator_style = "thick",
            },
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        enabled = true,
        event = "VeryLazy",
        config = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:❯]]
            vim.cmd("highlight FoldColumn guifg=" .. vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Comment')), 'fg'))

            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                setopt = true,
                relculright = true,
                segments = {
                    { text = { "%s" }, click = "v:lua.ScSa", },
                    {
                        text = { builtin.lnumfunc, " " },
                        condition = { true, builtin.not_empty },
                        click = "v:lua.ScLa",
                    },
                    {
                        text = { builtin.foldfunc, " " },
                        click = "v:lua.ScFa",
                        -- hi = "NonText",
                    },
                },
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                    tab_char = "▏",
                },
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                    include = {
                        node_type = {
                            lua = {
                                "return_statement",
                                "table_constructor"
                            }
                        }
                    }
                }
            })
        end
    },

    {
        'lukas-reineke/virt-column.nvim',
        event = "VeryLazy",
        enabled = true,
        opts = {
            char = "│",
            highlight = "iblindent",
            virtcolumn = "80, 120",
        }
    },

}

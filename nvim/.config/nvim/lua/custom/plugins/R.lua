return {

    {
        "R-nvim/R.nvim",
        lazy = false,
        keys = {
            {
                "<LocalLeader>gd",
                "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>",
                desc = "httpgd",
            },
            {
                "<LocalLeader>cl",
                "<Cmd>lua require('r.send').cmd('devtools::load_all()')<CR>",
                { desc = "R devtools [c]ode [l]oad all", silent = true }
            },
            {
                "<LocalLeader>cd",
                "<Cmd>lua require('r.send').cmd('devtools::document()')<CR>",
                { desc = "R devtools [c]ode [d]ocument", silent = true }
            },
        },
        config = function()
            local opts = {
                R_args = { "--quiet", "--no-save" },
                hook = {
                    on_filetype = function()
                        if vim.o.syntax ~= "rbrowser" then
                            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
                        end
                    end,
                },
                auto_start = "always",
                min_editor_width = 80,
                rconsole_width = 100,
                Rout_more_colors = true,
                listmethods = true,
                -- R starts in Neovim working directory
                setwd = "nvim",
                applescript = true,
                pdfviewer = "open",

                disable_cmds = {
                    "RClearConsole",
                    "RCustomStart",
                    "RSPlot",
                    "RSaveClose",
                },
            }
            require("r").setup(opts)

            -- Use tidyverse-style indentation (instead of weird stackoverflow style)
            -- NB, only applies if indent = { enabled = false } in treesitter config
            vim.g.r_indent_align_args = 0

            -- Highlight R output using normal colourscheme
            vim.g.rout_follow_colorscheme = true

            local wk = require('which-key')
            wk.add({
                { '<LocalLeader>a', group = 'All' },
                { '<LocalLeader>b', group = 'Between Marks' },
                { "<localleader>c", group = "Chunks" },
                { "<localleader>f", group = "Functions" },
                { "<localleader>g", group = "Goto" },
                { "<localleader>i", group = "Install" },
                { "<localleader>k", group = "Knit" },
                { "<localleader>p", group = "Paragraph" },
                { "<localleader>q", group = "Quarto" },
                { "<localleader>r", group = "R general" },
                { "<localleader>s", group = "Split or send" },
                { "<localleader>t", group = "Terminal" },
                { "<localleader>v", group = "View" },
            })
        end
    },

}

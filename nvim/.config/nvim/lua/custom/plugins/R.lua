return {

    {
        "R-nvim/R.nvim",
        lazy = false,
        config = function ()
            local opts = {
                R_args = {"--quiet", "--no-save"},
                hook = {
                    on_filetype = function()
                        if vim.o.syntax ~= "rbrowser" then
                            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
                            vim.api.nvim_buf_set_keymap(0, "n",
                                "<LocalLeader>cl",
                                "<Cmd>lua require('r.send').cmd('devtools::load_all()')<CR>",
                                { desc = "R: devtools::load_all()", silent = true }
                            )
                            vim.api.nvim_buf_set_keymap(0, "n",
                                "<LocalLeader>cd",
                                "<Cmd>lua require('r.send').cmd('devtools::document()')<CR>",
                                { desc = "R: devtools::document()", silent = true }
                            )
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
            -- vim.g.r_indent_align_args = 0

            -- Highlight R output using normal colourscheme
            -- vim.g.rout_follow_colorscheme = true

        end
    },

}

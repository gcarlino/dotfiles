return {

    {
        "R-nvim/R.nvim",
        lazy = false,
        config = function ()
            local opts = {
                R_args = {"--quiet", "--no-save"},
                hook = {
                    after_config = function()
                        if vim.o.syntax ~= "rbrowser" then
                            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                            vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
                        end
                    end,
                    vim.api.nvim_buf_set_keymap(0,
                        "n",
                        "<LocalLeader>cl",
						"<Cmd>lua require('r.send').cmd('devtools::load_all()')<CR>",
                        { desc = "R: devtools::load_all()", silent = true }
                    ),
                    vim.api.nvim_buf_set_keymap(0,
                        "n",
                        "<LocalLeader>cd",
						"<Cmd>lua require('r.send').cmd('devtools::document()')<CR>",
                        { desc = "R: devtools::document()", silent = true }
                    ),
                },
                auto_start = "always",
                min_editor_width = 80,
                rconsole_width = 1000,
                Rout_more_colors = true,
                listmethods = true,
                -- R starts in Neovim working directory
                setwd = "nvim",
                applescript = true,

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
            vim.g.rout_follow_colorscheme = true

        end
    },

    {
        "jalvesaq/Nvim-R",
        enabled = false,
        lazy = false,
        config = function()
            -- For radian
            -- vim.g.R_app = "radian"
            -- vim.g.R_cmd = "R"
            -- vim.g.R_args = {'--no-save'}
            -- vim.g.R_hl_term = 0
            -- vim.g.R_bracketed_paste = 1

            -- Nvim-R does not set the working directory in any way
            vim.g.R_nvim_wd = -1
            vim.g.rout_follow_colorscheme = 1
            vim.g.R_assign_map = '--'

            vim.g.R_min_editor_width = 80
            vim.g.R_rconsole_width = 1000

            -- vim.o.foldenable = false

            -- Shortcuts for package development
            vim.keymap.set("n", "<LocalLeader>dl", ":call g:SendCmdToR('devtools::load_all()')<CR>", { desc = "R: devtools::load_all()", silent = true })
            vim.keymap.set("n", "<LocalLeader>dd", ":call g:SendCmdToR('devtools::document()')<CR>", { desc = "R: devtools::document()", silent = true })
        end,
    },

}

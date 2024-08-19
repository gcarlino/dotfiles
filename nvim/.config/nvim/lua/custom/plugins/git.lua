-- Git
return {

    {
        'tpope/vim-fugitive',
        event = "VeryLazy"
    },

    {
        "lewis6991/gitsigns.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        event = "VeryLazy",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function set(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                set('n', ']h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = "Next hunk" }
                )

                set('n', '[h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = "Previous hunk" }
                )

                -- Actions
                set({ 'n', 'v' }, '<leader>hs', gitsigns.stage_hunk, { desc = "Git [s]tage hunk" })
                set({ 'n', 'v' }, '<leader>hr', gitsigns.reset_hunk, { desc = "Git [r]eset hunk" })
                set('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Git [S]tage buffer" })
                set('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Git [u]ndo stage hunk" })
                set('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Git [R]eset buffer" })
                set('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Git [p]review hunk" })
                set('n', '<leader>hb', function() gitsigns.blame_line{ full = true } end, { desc = "Git [b]lame line" })
                set('n', '<leader>hd', gitsigns.diffthis, { desc = "Git [d]iff this" })
                set('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Git [D]iff against last commit" })

                -- Toggles
                set('n', '<leader>ht', gitsigns.toggle_current_line_blame, { desc = "Git toggle current line blame" })
                set('n', '<leader>hl', gitsigns.toggle_deleted, { desc = "Git toggle deleted" })

            end
        },
    },

}

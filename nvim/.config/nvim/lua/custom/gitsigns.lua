-- lewis6991/gitsigns.nvim 
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', gitsigns.stage_hunk, { desc = "Git [s]tage hunk" })
        map({ 'n', 'v' }, '<leader>hr', gitsigns.reset_hunk, { desc = "Git [r]eset hunk" })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Gitsigns: [S]tage buffer" })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Gitsigns: [u]ndo stage hunk" })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Gitsigs: [R]eset buffer" })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Gitsigns: [p]review hunk" })
        map('n', '<leader>hb', function() gitsigns.blame_line{ full = true } end, { desc = "Gitsigns: [b]lame line" })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = "Gitsigns: [d]iff this" })
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Gitsigns: [D]iff against last commit" })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Gitsigns: toggle current line blame" })
        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Gitsign: toggle deleted" })

    end
})

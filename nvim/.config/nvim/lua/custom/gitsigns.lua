local status, gitsigns = pcall(require, 'gitsigns')
if not status then
    return
end


-- lewis6991/gitsigns.nvim 
gitsigns.setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "Git next hunk" })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "Git prev hunk" })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', function () gs.stage_hunk() end, { desc = "Git [s]tage hunk" })
        map({ 'n', 'v' }, '<leader>hr', function () gs.reset_hunk() end, { desc = "Git [r]eset hunk" })
        map('n', '<leader>hS', function() gs.stage_buffer() end, { desc = "Gitsigns: [S]tage buffer" })
        map('n', '<leader>hu', function() gs.undo_stage_hunk() end, { desc = "Gitsigns: [u]ndo stage hunk" })
        map('n', '<leader>hR', function() gs.reset_buffer() end, { desc = "Gitsigs: [R]eset buffer" })
        map('n', '<leader>hp', function() gs.preview_hunk() end, { desc = "Gitsigns: [p]review hunk" })
        map('n', '<leader>hb', function() gs.blame_line{ full = true } end, { desc = "Gitsigns: [b]lame line" })
        map('n', '<leader>hd', function() gs.diffthis() end, { desc = "Gitsigns: [d]iff this" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Gitsigns: [D]iff against last commit" })

        -- Toggles
        map('n', '<leader>tb', function() gs.toggle_current_line_blame() end, { desc = "Gitsigns: toggle current line blame" })
        map('n', '<leader>td', function() gs.toggle_deleted() end, { desc = "Gitsign: toggle deleted" })

        -- Text object
        -- map({ 'o', 'x' }, '<ldeader>ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Gitsigns: select hunk" })
    end
})

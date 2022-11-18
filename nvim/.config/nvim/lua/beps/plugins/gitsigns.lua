local status, gitsigns = pcall(require, 'gitsigns')
if not status then
    return
end


-- lewis6991/gitsigns.nvim 
gitsigns.setup({
    signs     = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
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
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns: stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns: reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer, { desc = "Gitsigns: stage buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Gitsigns: undo stage hunk" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "Gitsigs: reset buffer" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Gitsigns: preview hunk" })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Gitsigns: blame line" })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Gitsigns: toggle current line blame" })
        map('n', '<leader>hd', gs.diffthis, { desc = "Gitsigns: diff this" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Gitsigns: diff this against last commit" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "Gitsign:  toggle deleted" })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})


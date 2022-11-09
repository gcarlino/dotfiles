require("beps.options")

-- Remap space as leader key and ; as local leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- Mac spefic configuration
if vim.fn.has("mac") == 1 then
    require("beps.mac")
end

require("beps.keymaps")
require("beps.disable_builtin")

require("beps.plugins-setup")


-- lewis6991/impatient.nvim 
require('impatient')

require('beps.colorscheme')
require('beps.plugins.treesitter')
require('beps.plugins.telescope')
require('beps.plugins.dap')
require('beps.lsp.lsp')
require('beps.plugins.nvim-cmp')


-- kyazdani42/nvim-web-devicons {{{
require('nvim-web-devicons').setup {
    default = true,
}
-- }}}


-- alvarosevilla95/luatab.nvim 
require('luatab').setup {}


-- hoob3rt/lualine.nvim
require("beps.plugins.lualine")


-- lukas-reineke/indent-blankline.nvim
require("indent_blankline").setup {
    show_current_context = true,
    -- show_current_context_start = true,
    show_end_of_line = true,
}


-- lewis6991/gitsigns.nvim 
require('gitsigns').setup {
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
}



-- use akinsho/toggleterm.nvim 
require("toggleterm").setup {
    open_mapping = [[<c-q>]],
}

-- Mappings to make moving in and out of a terminal easier once toggled,
-- whilst still keeping it open
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- j-hui/fidget.nvim
require "fidget".setup {}


-- kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
    git = {
        ignore = false
    }
})


-- chentoast/marks.nvim
require 'marks'.setup({})


-- kevinhwang91/nvim-ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds." })
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds." })
--
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

-- global handler
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end,
    fold_virt_text_handler = handler
})


-- jalvesazq/Nvim-R
vim.cmd([[
    let R_assign_map = '<M-->'
    let rout_follow_colorscheme = 1
    let r_syntax_folding = 1
    set nofoldenable
    autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
]])


-- windwp/nvim-autopairs
require('nvim-autopairs').setup({})


-- numToStr/Comment.nvim
require('Comment').setup()


-- kylechui/nvim-surround
require('nvim-surround').setup({})


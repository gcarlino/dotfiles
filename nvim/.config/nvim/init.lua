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

-- lewis6991/impatient.nvim 
require('impatient')

require("plugins")

require('beps.colorscheme')
require('beps.plugins.treesitter')
require('beps.plugins.telescope')
require('beps.plugins.dap')
require('beps.lsp')
require('beps.plugins.nvim-cmp')
require('beps.plugins.gitsigns')
require('beps.plugins.diffview')
require("beps.plugins.lualine")


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

--
-- kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
    hijack_netrw = false,
    git = {
        ignore = false
    }
})


-- kevinhwang91/nvim-ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.fillchars = vim.opt.fillchars + 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'

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

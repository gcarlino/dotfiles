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
require('beps.plugins.nvim-ufo')


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

-- -- jalvesazq/Nvim-R
-- vim.cmd([[
--     let R_assign_map = '<M-->'
--     let rout_follow_colorscheme = 1
--     let r_syntax_folding = 1
--     set nofoldenable
--     autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
-- ]])

-- Remap space as leader key and ; as local leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = 'Open tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set("n", "]t", ":tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[t", ":tabprevious<cr>", { desc = "Previous tab" })

-- Splits
vim.keymap.set('n', '<C-h>', '<C-w>h', {desc = 'Move to left split.'})
vim.keymap.set('n', '<C-j>', '<C-w>j', {desc = 'Move to lower split.'})
vim.keymap.set('n', '<C-k>', '<C-w>k', {desc = 'Move to upper split.'})
vim.keymap.set('n', '<C-l>', '<C-w>l', {desc = 'Move to right split.'})

-- Edit config file
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>', { desc = "Edit init.lua" })

-- No highlight
vim.keymap.set('n', '<CR>', ':noh<CR>', { desc = "No highlight" })

-- Move lines around
vim.api.nvim_set_keymap('n', '<M-k>', ':m .-2<CR>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-j>', ':m .+1<CR>==', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-j>', '<ESC>:m .+1<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-k>', '<ESC>:m .-2<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<M-j>', ":m '>+1<CR>gv==gv", { noremap = true })
vim.api.nvim_set_keymap('v', '<M-k>', ":m '<-2<CR>gv==gv", { noremap = true })

-- Change current directory to working file path
vim.keymap.set('n', '<leader>cd', '<cmd>cd %:p:h<CR>:pwd<CR>',
    { noremap = true, silent = true, desc = "Change current directory to working file path." })

-- Quickfixlist navigation
vim.keymap.set("n", "]q", ":cnext<cr>", { desc = "Next item in quickfix list" })
vim.keymap.set("n", "[q", ":cprevious<cr>", { desc = "Previous item in quickfix list" })

-- nvim-tree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle nvim-tree." })

-- Diffview
vim.keymap.set('n', '<leader>vo', ':DiffviewOpen<CR>', { noremap = true, desc = "Open Diffview tab."})
vim.keymap.set('n', '<leader>vc', ':DiffviewClose<CR>', { noremap = true, desc = "Close Diffview tab."})

-- Custom comments
vim.keymap.set('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end,
    { desc = "Toggle comment on current line" })
vim.keymap.set('x', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
    { desc = "Toggle comment on current line" })

-- Allow gf to open non-existent files
vim.keymap.set('', 'gf', ':edit <cfile><CR>')


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


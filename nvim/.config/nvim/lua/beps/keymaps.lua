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
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle nvim-tree." })



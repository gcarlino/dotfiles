-- Global mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostics" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostics" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics [Q]uickfix list" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostics [E]rror messages" })

-- Move around selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Search and stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Page up and down and stay in the middle
vim.keymap.set("n", "<c-d>", "<c-d>zz", {})
vim.keymap.set("n", "<c-u>", "<c-u>zz", {})

-- yank in system clipboard
-- vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = 'Open tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set("n", "]t", ":tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[t", ":tabprevious<cr>", { desc = "Previous tab" })

-- Splits
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left split.' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower split.' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper split.' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right split.' })

-- Change split size
vim.keymap.set({ 'n', 't'}, '<M-l>', '5<C-w><', { noremap = false })
vim.keymap.set({ 'n', 't'}, '<M-h>', '5<C-w>>', { noremap = false })

-- No highlight
vim.keymap.set('n', '<C-c>', ':noh<CR>', { desc = "No highlight" })

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
-- vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle nvim-tree." })

-- Allow gf to open non-existent files
-- vim.keymap.set('', 'gf', ':edit <cfile><CR>')

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

-- vim.keymap.set("n", "<D-/>", ":lua require('Comment.api').toggle.linewise.current(); vim.cmd('normal j')<CR>", {silent=true})
-- vim.keymap.set("n", "<D-/>", ":lua require('Comment.api').toggle.linewise.current()<CR>", {silent=true})
-- vim.keymap.set("v", "<D-/>", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {silent=true})

-- Toggle backgournd color TODO: move to colorscheme configuration
vim.api.nvim_set_keymap("n", "<leader>b", "", {
    noremap = true,
    callback = function()
        local _background = vim.api.nvim_get_option_value("background", {})
        if (_background == "light") then

            -- If colorscheme is nightfox (catpuccin is automatic)
            local status = pcall(require, "nightfox")
            if status then
                vim.cmd('colorscheme nordfox')
            end

            local ostatus = pcall(require, "onedarkpro")
            if ostatus then
                vim.cmd('colorscheme onedark')
            end

            vim.api.nvim_set_option_value("background", "dark", {})
        else
            -- If colorscheme is nightfox (catpuccin is automatic)
            local status = pcall(require, 'nightfox')
            if status then
                vim.cmd('colorscheme dayfox')
            end

            local ostatus = pcall(require, 'onedarkpro')
            if ostatus then
                vim.cmd('colorscheme onelight')
            end

            vim.api.nvim_set_option_value("background", "light", {})
        end
    end,
    desc = "Toggle background color."
})

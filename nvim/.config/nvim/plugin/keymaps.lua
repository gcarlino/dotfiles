-- Global mappings

local set = vim.keymap.set

set('n', '<leader>q', vim.diagnostic.setqflist, { desc = "Open diagnostics [Q]uickfix list" })
set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show [D]iagnostics error messages" })
-- These are builtin but I override them to show the error messsage
set('n', ']d', function () vim.diagnostic.jump({ count = 1, float = true}) end, { desc = "Goto next [d]iagnostics"})
set('n', '[d', function () vim.diagnostic.jump({ count = -1, float = true}) end, { desc = "Goto previous [d]iagnostics"})

-- Quickfixlist navigation
set("n", "]q", ":cnext<cr>", { desc = "Next item in quickfix list" })
set("n", "[q", ":cprevious<cr>", { desc = "Previous item in quickfix list" })

-- Search and stay in the middle
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Page up and down and stay in the middle
set("n", "<c-d>", "<c-d>zz", {})
set("n", "<c-u>", "<c-u>zz", {})

-- Tabs
set("n", "]t", ":tabnext<cr>", { desc = "Next tab" })
set("n", "[t", ":tabprevious<cr>", { desc = "Previous tab" })

-- Splits
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left split.' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower split.' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper split.' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right split.' })

-- Change split size
set({ 'n', 't'}, '<M-h>', '5<C-w><', { noremap = false })
set({ 'n', 't'}, '<M-l>', '5<C-w>>', { noremap = false })
set({ 'n', 't'}, '<M-j>', '5<C-w>-', { noremap = false })
set({ 'n', 't'}, '<M-k>', '5<C-w>+', { noremap = false })

-- Clear highlight
set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Change current directory to working file path
-- set('n', '<leader>cd', '<cmd>cd %:p:h<CR>:pwd<CR>',
--     { noremap = true, silent = true, desc = "Change current directory to working file path." })

-- Mappings to make moving in and out of a terminal easier once toggled,
-- whilst still keeping it open
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = "*",
    callback = function()
        local opts = { buffer = 0 }
        set('t', '<esc>', [[<C-\><C-n>]], opts)
        set('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
        set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
        set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
        set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
        set('t', '<C-w><C-h>', [[<Cmd>wincmd h<CR>]], opts)
        set('t', '<C-w><C-j>', [[<Cmd>wincmd j<CR>]], opts)
        set('t', '<C-w><C-k>', [[<Cmd>wincmd k<CR>]], opts)
        set('t', '<C-w><C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end
})
-- Toggle line wrap
set("n", "<leader>tw", ":set wrap!<CR>", { desc = "[T]oggle line [w]rap" })

-- Toggle backgournd color TODO: move to colorscheme configuration
vim.api.nvim_set_keymap("n", "<leader>tc", "", {
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
    desc = "[T]oggle background [c]olor."
})

-- Global mappings

local set = vim.keymap.set

set('n', '<leader>q', vim.diagnostic.setqflist, { desc = "Open diagnostics [Q]uickfix list" })
set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show [D]iagnostics error messages" })
-- These are builtin but I override them to show the error message
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
set({ 'n', 't'}, '<C-S-h>', '5<C-w><', { noremap = false })
set({ 'n', 't'}, '<C-S-l>', '5<C-w>>', { noremap = false })
set({ 'n', 't'}, '<C-S-j>', '1<C-w>-', { noremap = false })
set({ 'n', 't'}, '<C-S-k>', '1<C-w>+', { noremap = false })
-- set({ 'n', 't'}, '<M-h>', '5<C-w><', { noremap = false })
-- set({ 'n', 't'}, '<M-l>', '5<C-w>>', { noremap = false })
-- set({ 'n', 't'}, '<M-j>', '5<C-w>-', { noremap = false })
-- set({ 'n', 't'}, '<M-k>', '5<C-w>+', { noremap = false })

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
        set('t', '<Esc>', [[<C-\><C-n>]], opts)
        set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

        vim.opt.spell = false
    end
})
-- vim.cmd('autocmd! TermOpen term://* lua set_my_terminal_keymaps()')

-- Toggle line wrap
set("n", "<leader>tw", ":set wrap!<CR>", { desc = "[T]oggle line [w]rap" })

-- Toggle conceallevel
set("n", "<leader>tl",
  function()
    local cl = vim.api.nvim_get_option_value('conceallevel', {})
        if cl == 1 then
            vim.opt.conceallevel = 0
        else
            vim.opt.conceallevel = 1
        end
  end,
    { desc = "[T]oggle conceal[L]evel" })

-- Insert creation date/time of current buffer at cursor position
set("n", "<LocalLeader>d", function()
    local buf = vim.api.nvim_buf_get_name(0)
    local sec = vim.uv.fs_stat(buf).birthtime.sec
    local formattedDateTime = vim.fn.strftime("%Y-%m-%d %H:%M:%S", sec)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, {formattedDateTime})
end, { desc = "Insert creation datetime of current buffer" } )


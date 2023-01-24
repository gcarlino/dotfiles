vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.diffopt = 'internal,filler,closeoff,vertical'
-- vim.opt.laststatus = 3 -- Global status line
vim.opt.clipboard = 'unnamedplus' -- Copy to system clipboard
vim.opt.confirm = true -- ask for confirmation instead of erroring
vim.opt.spelllang = { 'en_us', 'it' } -- Spellcheck languages
vim.opt.shortmess:append({ I = true }) -- disable the splash screen
vim.opt.showmode = false
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Highlight on yank
local yankHighlightGroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = yankHighlightGroup,
    pattern = "*"
})

-- listchars
vim.opt.listchars = {
    tab = '▸ ',
    trail = '·',
    precedes = '←',
    extends = '→',
    conceal = '┊',
    eol = '↲',
    nbsp = '␣'
}
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.opt.list = true
    end
})
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "InsertLeave" }, {
    pattern = "*",
    callback = function()
        vim.opt.list = false
    end
})

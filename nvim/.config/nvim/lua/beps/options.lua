vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

local opt = vim.opt

opt.autowrite = true
opt.clipboard = 'unnamedplus' -- Copy to system clipboard
opt.confirm = true -- ask for confirmation instead of erroring
opt.cursorline = true
opt.diffopt = 'internal,filler,closeoff,vertical,linematch'
opt.expandtab = true
opt.ignorecase = true
opt.laststatus = 0
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append({ I = true }) -- disable the splash screen
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.updatetime = 200
opt.wrap = false
opt.colorcolumn = '80'

-- Enable spell check
opt.spelllang = { 'en_us', 'it' } -- Spellcheck languages
-- opt.spell = true

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

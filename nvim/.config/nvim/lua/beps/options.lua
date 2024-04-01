vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

vim.opt.autowrite = true
vim.opt.clipboard = 'unnamedplus' -- Copy to system clipboard
vim.opt.confirm = true -- ask for confirmation instead of erroring
vim.opt.cursorline = true
vim.opt.diffopt = 'internal,filler,closeoff,vertical'
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.laststatus = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.colorcolumn = '80'
vim.opt.hlsearch = true
vim.opt.inccommand= 'split'

-- vim.opt.shortmess:append({ S = true }) -- disable search count

-- Spell check is enabled by file type
vim.opt.spelllang = { 'en_us', 'it' }

-- Disable netrw (as required by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    callback = function()
        vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
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

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

-- Folding in treesitter
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:⊟,foldsep: ,foldclose:⊞]]
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

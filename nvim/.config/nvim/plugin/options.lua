-- Write the contents of the file, if it has been modified
-- vim.opt.autowrite = true

-- Sync clipboard between OS and neovim. Schedule the setting after `UIEnter`.
vim.schedule(function ()
    vim.opt.clipboard = 'unnamedplus'
end)
-- vim.opt.clipboard = 'unnamedplus'

-- This is to preserve creation date of files (see help)
vim.opt.backupcopy = "yes"

-- Ask for confirmation instead of erroring
vim.opt.confirm = true

-- Highlight the text line of the cursor
vim.opt.cursorline = true

vim.opt.diffopt = 'internal,filler,closeoff,vertical'
vim.opt.expandtab = true

-- Case insensitive searching unless one or more capital letter in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.laststatus = 0

vim.opt.number = true
vim.opt.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 4

vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Don't show the mode (it's in the status line)
vim.opt.showmode = false

-- Always show signcolumn
vim.opt.signcolumn = 'yes'

-- vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.linebreak = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true

-- Save undo history
vim.opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 200

-- vim.opt.colorcolumn = '80'

-- Options for insert mode completions
vim.opt.completeopt = 'menu,menuone,noinsert,noselect,preview'

-- Preview substitutions live
vim.opt.inccommand= 'split'

vim.opt.conceallevel = 0

vim.opt.maxmempattern = 9999

-- vim.opt.shortmess:append({ S = true }) -- disable search count

-- Spell check is enabled by file type
vim.opt.spell = false
vim.opt.spelllang = { 'en_gb', 'it' }

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

-- fillchars
vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
    foldopen = '',
    foldsep = ' ',
    foldclose = '❯',
    diff = '╱'
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

-- vim.api.nvim_create_autocmd("TermOpen", {
--     pattern = "*",
--     callback = function()
--         vim.opt.number = false
--         vim.opt.relativenumber = false
--     end
-- })

-- Folding in treesitter
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

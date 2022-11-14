-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.o.termguicolors = true

-- Highlight the text line of the cursor
vim.opt.cursorline = true

-- Enable break indent
vim.opt.breakindent = true
-- Case insensitive search unless /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 4
vim.o.diffopt = 'internal,filler,closeoff,vertical'

-- Global status line
vim.opt.laststatus = 3
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "dapui*", "dap-repl" },
--     callback = function()
--         vim.opt.laststatus = 2
--     end
-- })


-- Copy to system clipboard
vim.api.nvim_set_option('clipboard', 'unnamed')

-- Highlight syntax inside markdown
vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'r', 'sh' }

-- Spellcheck
vim.opt.spell = false
vim.opt.spelllang = { 'en_us', 'it' }

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


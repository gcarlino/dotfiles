vim.g.fortran_fixed_source = 1
vim.o.tabstop = 6
vim.o.shiftwidth = 6
vim.o.softtabstop = 6
vim.bo.commentstring = "C%s"

-- LSP
vim.lsp.start({
    name = 'fortls',
    cmd = {
        'fortls',
    },
    filetypes = { 'fortran', 'fortran77' },
    root_dir = vim.fs.dirname(vim.fs.find({'.fortls'}, { upward = true })[1]),
    settings = {},
})
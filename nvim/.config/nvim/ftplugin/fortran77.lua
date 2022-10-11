vim.g.fortran_fixed_source = 1
vim.o.tabstop = 6
vim.o.shiftwidth = 6
vim.o.softtabstop = 6
vim.bo.commentstring = "C%s"

-- LSP
vim.lsp.start({
    name = 'fortls',
    cmd = {'fortls'},
    root_dir = vim.fs.dirname(vim.fs.find({'.fortls'}, { upward = true })[1]),
    -- on_attach = on_attach(_, bufnr),
    settings = {
        notifyInit = true,
        lowercaseIntrinsics = true,
        enableCodeActions = true
    },
})


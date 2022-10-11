-- LSP
vim.lsp.start({
    name = 'fortls',
    filetypes = {'fortran'},
    cmd = {'fortls'},
    root_dir = vim.fs.dirname(vim.fs.find({'.fortls'}, { upward = true })[1]),
    -- on_attach = on_attach(_, bufnr),
    settings = {
        notifyInit = true,
        lowercaseIntrinsics = true,
        enableCodeActions = true
    },
})

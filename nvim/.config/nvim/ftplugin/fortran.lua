-- LSP
vim.lsp.start({
    name = 'fortls',
    filetypes = {'fortran', 'fortran77' },
    cmd = {
        'fortls',
        '--lowercase_intrinsics',
        '--use_signature_help',
        '--hover_signature',
        '--enable_code_actions',
    },
    root_dir = vim.fs.dirname(vim.fs.find({'.fortls'}, { upward = true })[1]),
    -- on_attach = on_attach(_, bufnr),
    settings = {},
})

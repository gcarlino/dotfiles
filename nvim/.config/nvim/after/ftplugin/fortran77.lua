vim.g.fortran_fixed_source = 1
vim.o.tabstop = 6
vim.o.shiftwidth = 6
vim.o.softtabstop = 6
vim.bo.commentstring = "C%s"

-- require('lsp.fortls')
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

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.cmd('let fortran_do_enddo=1')

-- The following lines are to config the LSP without nvim-lspconfig
--
-- vim.lsp.start({
--     name = 'fortls',
--     filetypes = {'fortran', 'fortran77' },
--     cmd = {
--         'fortls',
--         '--lowercase_intrinsics',
--         '--use_signature_help',
--         '--hover_signature',
--         '--enable_code_actions',
--     },
--     root_dir = vim.fs.dirname(vim.fs.find({'.fortls'}, { upward = true })[1]),
--     settings = {},
-- })

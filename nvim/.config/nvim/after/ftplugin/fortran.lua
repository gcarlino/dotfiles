-- -- Change options if fortran77 or note
-- if vim.fn.search("^C", "nw", 500) ~= 0 then
--     vim.opt_local.tabstop = 6
--     vim.opt_local.shiftwidth = 6
--     vim.opt_local.softtabstop = 6
--     vim.cmd("local c_str = 'C'")
-- else
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
-- end

-- vim.o.syntax = "fortran"
-- vim.cmd('let fortran_free_source=1')

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

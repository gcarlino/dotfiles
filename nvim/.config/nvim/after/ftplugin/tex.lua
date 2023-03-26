vim.opt.spell = true

-- The following lines are to config the LSP without nvim-lspconfig
--
-- vim.lsp.start({
--     name = 'texlab',
--     cmd = { 'texlab' },
--     filetypes = { 'tex', 'plaintex', 'bib' },
--     root_dir = vim.fs.dirname( vim.fs.find( { '.fdb_latexmark' }, { upward = true })[1]),
-- })

-- The following lines are to config the LSP without nvim-lspconfig
--
-- vim.lsp.start({
--     name = 'clangd',
--     cmd = { 'clangd' },
--     filetypes = { 'c', 'cpp' },
--     root_dir = vim.fs.dirname(
--         vim.fs.find(
--             {'.git', '.clangd' },
--             { upward = true })[1]),
-- })

vim.cmd[[let g:python3_host_prog = '/Users/beps/.virtualenvs/neovim3/bin/python3' ]]

-- The following lines are to config the LSP without nvim-lspconfig
--
-- vim.lsp.start({
--     name = 'pylsp',
--     filetypes = { 'python' },
--     cmd = {'pylsp'},
--     root_dir = vim.fs.dirname(
--         vim.fs.find(
--             {'setup.py', 'pyproject.toml', 'requirements.txt'},
--             { upward = true })[1]),
-- })

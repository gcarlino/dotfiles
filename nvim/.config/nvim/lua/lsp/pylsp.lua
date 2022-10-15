vim.lsp.start({
    name = 'pylsp',
    filetypes = { 'python' },
    cmd = {'pylsp'},
    root_dir = vim.fs.dirname(
        vim.fs.find(
            {'setup.py', 'pyproject.toml', 'requirements.txt'},
            { upward = true })[1]),
})

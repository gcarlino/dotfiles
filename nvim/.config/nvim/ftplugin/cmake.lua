vim.lsp.start({
    name = 'cmake',
    filetypes = {'cmake'},
    cmd = {'cmake-language-server'},
    root_dir = vim.fs.dirname(
        vim.fs.find(
            {'CmakeLists.txt', 'build' },
            { upward = true })[1]),
})
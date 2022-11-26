vim.opt.wrap = true

-- require('lsp.marksman')
vim.lsp.start({
    name = 'marksman',
    filetypes = { 'markdown' },
    cmd = { 'marksman', 'server' },
    root_dir = vim.fs.dirname(vim.fs.find({'.marksman.toml'}, { upward = true })[1]),
    settings = {
    },
})

vim.opt.wrap = true
vim.opt.spell = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.conceallevel = 2
-- Highlight syntax inside markdown
vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'r', 'sh' }


-- -- require('lsp.marksman')
-- vim.lsp.start({
--     name = 'marksman',
--     filetypes = { 'markdown' },
--     cmd = { 'marksman', 'server' },
--     root_dir = vim.fs.dirname(vim.fs.find({'.marksman.toml'}, { upward = true })[1]),
--     settings = {
--     },
-- })

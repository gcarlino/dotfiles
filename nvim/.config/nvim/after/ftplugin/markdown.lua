vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
-- vim.opt_local.conceallevel = 2
-- Highlight syntax inside markdown
-- vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'r', 'sh' }


-- -- require('lsp.marksman')
-- vim.lsp.start({
--     name = 'marksman',
--     filetypes = { 'markdown' },
--     cmd = { 'marksman', 'server' },
--     root_dir = vim.fs.dirname(vim.fs.find({'.marksman.toml'}, { upward = true })[1]),
--     settings = {
--     },
-- })

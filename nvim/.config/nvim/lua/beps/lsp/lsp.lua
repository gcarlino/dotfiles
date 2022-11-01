vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>di', function() require('telescope.builtin').diagnostics() end,
    { desc = "Document diagnostics" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, keymapOpts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
    { desc = "Add buffer diagnostic to the location list" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)

--     -- Trigger completion with <c-x><c-o>
        -- vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local bufopts = { buffer = args.buf, noremap = true, silent = true }

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
            { desc = "Jumps to the definition of the type of the symbol under the cursor." })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
            { desc = "Renames all references to the symbol under the cursor." })
        vim.keymap.set('n', '<leader>so',
            function()
                require('telescope.builtin').lsp_document_symbols()
            end,
            { desc = "Lists LSP symbols in the current buffer" })

        -- additional capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- nvim-cmp supports additional completion capabilities
        -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- -- tell the sever the capability of foldingRange
        -- capabilities.textDocument.foldingRange = {
        --     dynamicRegistration = false,
        --     lineFoldingOnly = true
        -- }

    end
})

-- -- additional capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- -- nvim-cmp supports additional completion capabilities
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--
-- -- -- tell the sever the capability of foldingRange
-- -- capabilities.textDocument.foldingRange = {
-- --     dynamicRegistration = false,
-- --     lineFoldingOnly = true
-- -- }


vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
    }
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local status, saga = pcall(require, 'lspsaga')
if not status then
    return
end

-- Lspsaga setup
saga.init_lsp_saga({
    border_style = "rounded",
    show_outline = {
        win_width = 35,
        auto_preview = false,
    }
})

-- vim.keymap.set('n', '<leader>di', function() require('telescope.builtin').diagnostics() end,
--     { desc = "Document diagnostics" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, keymapOpts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
--     { desc = "Add buffer diagnostic to the location list" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)

        local bufdesc = function (mdesc)
            local bufdesc = { buffer = args.buf, noremap = true, silent = true, desc = mdesc }
            return bufdesc
        end
        local bufopts = { buffer = args.buf, noremap = true, silent = true, desc = "LSP" }

        -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>',
            bufopts
        )
        vim.keymap.set('n', '<leader>lf', '<cmd>Lspsaga lsp_finder<cr>',
            bufdesc("LSP finder")
        )
        vim.keymap.set('n', '<leader>lF', vim.lsp.buf.format,
            bufdesc("LSP buffer format")
        )
        vim.keymap.set('n', 'gr', vim.lsp.buf.references,
            bufdesc("LSP references")
        )
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
            bufdesc("LSP implementation")
        )
        -- vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'ga', '<cmd>Lspsaga code_action<cr>',
            bufdesc("LSP code action")
        )
        vim.keymap.set('n', '<leader>lo', '<cmd>Lspsaga outline<cr>',
            bufdesc("LSP outline")
        )
        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<cr>',
            bufdesc("LSP peek definition")
        )
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
            bufdesc("LSP declaration")
        )
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
            bufdesc("LSP type definition")
        )
        -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<cr>',
            bufdesc("LSP rename")
        )
        vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<cr>',
            bufdesc("LSP show line diagnostic")
        )
        vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>',
            bufdesc("Goto prev diagnostic")
        )
        vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>',
            bufdesc("Goto next diagnostic")
        )

        -- -- Telescope LSP commands
        vim.keymap.set('n', '<leader>lt', function() require('telescope.builtin').diagnostics() end,
            bufdesc("LSP document diagnostics ")
        )
        vim.keymap.set('n', '<leader>lr',
            function() require('telescope.builtin').lsp_references() end,
            { desc = "LSP refs for word under cursor " }
        )
        vim.keymap.set('n', '<leader>ls',
            function() require('telescope.builtin').lsp_document_symbols() end,
            { desc = "LSP document symbols " }
        )

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

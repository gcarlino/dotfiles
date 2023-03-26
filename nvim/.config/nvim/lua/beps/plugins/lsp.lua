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

-- local status, saga = pcall(require, 'lspsaga')
-- if not status then
--     return
-- end
--
-- -- Lspsaga setup
-- saga.setup({
--   symbol_in_winbar = {
--     enable = false,
--     separator = ' ',
--     hide_keyword = true,
--     show_file = true,
--     folder_level = 2,
--   },
-- })
-- saga.init_lsp_saga({
--     border_style = "rounded",
--     show_outline = {
--         win_width = 35,
--         auto_preview = false,
--     }
-- })

-- vim.keymap.set('n', '<leader>di', function() require('telescope.builtin').diagnostics() end,
--     { desc = "Document diagnostics" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, keymapOpts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
-- vim.keymap.aset('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
--     { desc = "Add buffer diagnostic to the location list" })

local lstatus, lspconfig = pcall(require, 'lspconfig')
if not lstatus then
    return
end

lspconfig.pylsp.setup({})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
    },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },

})
lspconfig.texlab.setup({})
lspconfig.clangd.setup({})
lspconfig.cmake.setup({})
lspconfig.fortls.setup({
    filetypes = {'fortran', 'fortran77'},
})
lspconfig.marksman.setup({})
lspconfig.r_language_server.setup({})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),

    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- additional capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- nvim-cmp supports additional completion capabilities
        -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    end,
    -- callback = function(args)
    --
    --     local bufdesc = function (mdesc)
    --         local bufdesc = { buffer = args.buf, noremap = true, silent = true, desc = mdesc }
    --         return bufdesc
    --     end
    --     local bufopts = { buffer = args.buf, noremap = true, silent = true, desc = "LSP" }
    --
    --     -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    --     vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>',
    --         bufopts
    --     )
    --     vim.keymap.set('n', '<leader>lf', '<cmd>Lspsaga lsp_finder<cr>',
    --         bufdesc("LSP finder")
    --     )
    --     vim.keymap.set('n', '<leader>lF', vim.lsp.buf.format,
    --         bufdesc("LSP buffer format")
    --     )
    --     vim.keymap.set('n', 'gr', vim.lsp.buf.references,
    --         bufdesc("LSP references")
    --     )
    --     vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    --         bufdesc("LSP implementation")
    --     )
    --     -- vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
    --     vim.keymap.set('n', 'ga', '<cmd>Lspsaga code_action<cr>',
    --         bufdesc("LSP code action")
    --     )
    --     vim.keymap.set('n', '<leader>lo', '<cmd>Lspsaga outline<cr>',
    --         bufdesc("LSP outline")
    --     )
    --     -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    --     vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<cr>',
    --         bufdesc("LSP peek definition")
    --     )
    --     vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
    --         bufdesc("LSP declaration")
    --     )
    --     -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    --     vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
    --         bufdesc("LSP type definition")
    --     )
    --     -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
    --     vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<cr>',
    --         bufdesc("LSP rename")
    --     )
    --     vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<cr>',
    --         bufdesc("LSP show line diagnostic")
    --     )
    --     vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>',
    --         bufdesc("Goto prev diagnostic")
    --     )
    --     vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>',
    --         bufdesc("Goto next diagnostic")
    --     )
    --
    --     -- -- Telescope LSP commands
    --     vim.keymap.set('n', '<leader>lt', function() require('telescope.builtin').diagnostics() end,
    --         bufdesc("LSP document diagnostics ")
    --     )
    --     vim.keymap.set('n', '<leader>lr',
    --         function() require('telescope.builtin').lsp_references() end,
    --         { desc = "LSP refs for word under cursor " }
    --     )
    --     vim.keymap.set('n', '<leader>ls',
    --         function() require('telescope.builtin').lsp_document_symbols() end,
    --         { desc = "LSP document symbols " }
    --     )
    --
    --     -- additional capabilities
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --
    --     -- nvim-cmp supports additional completion capabilities
    --     -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    --     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    --
    --     -- -- tell the sever the capability of foldingRange
    --     -- capabilities.textDocument.foldingRange = {
    --     --     dynamicRegistration = false,
    --     --     lineFoldingOnly = true
    --     -- }
    -- end
})

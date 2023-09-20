vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always'
    }
})

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = ' ', Warn = ' ', Info = ' ', Hint = ' ' }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { icon = icon, texthl = hl, numhl = hl })
end

local lstatus, lspconfig = pcall(require, 'lspconfig')
if not lstatus then
    return
end

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                },
                maccabe = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                },
                flake8 = {
                    enabled = true,
                    ignore = { 'E203' },
                    maxLineLength = 88,
                }
            }
        }
    }
})

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
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
    filetypes = { 'fortran', 'fortran77' },
})
lspconfig.marksman.setup({})
lspconfig.r_language_server.setup({})

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local optsDesc = function(ev, mdesc)
    local opts = { buffer = ev.buf, noremap = true, silent = true, desc = mdesc }
    return opts
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, optsDesc(ev, 'LSP goto declaration'))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, optsDesc(ev, 'LSP goto definition'))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, optsDesc(ev, 'LSP show hover information.'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, optsDesc(ev, 'Show implementation.'))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, optsDesc(ev, 'LSP signature help'))
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, optsDesc(ev, 'LSP add workspace folder'))
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, optsDesc(ev, 'LSP remove workspace folder'))
        vim.keymap.set('n', '<space>wl',
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            optsDesc(ev, 'LSP list workspace folders'))
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, optsDesc(ev, 'LSP type definition.'))
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, optsDesc(ev, 'LSP buffer rename'))
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, optsDesc(ev, 'LSP buffer code action.'))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, optsDesc(ev, 'LSP references.'))
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end,
            optsDesc(ev, 'LSP buffer format'))

        -- Telescope LSP commands
        vim.keymap.set('n', '<leader>lt', function() require('telescope.builtin').diagnostics() end,
            optsDesc(ev, 'LSP document diagnostics '))
        vim.keymap.set('n', '<leader>lr',
            function() require('telescope.builtin').lsp_references() end,
            { desc = 'LSP refs for word under cursor ' })
        vim.keymap.set('n', '<leader>ls',
            function() require('telescope.builtin').lsp_document_symbols() end,
            { desc = 'LSP document symbols ' })

        -- additional capabilities
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- -- nvim-cmp supports additional completion capabilities
        -- -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        -- local cstatus, cmp = pcall(require, 'cmp_nvim_lsp')
        -- if cstatus then
        --     capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        -- end
    end,
    -- callback = function(args)
    --
    --     -- additional capabilities
    --     local capabilities = vim.lsp.protocol.make_client_capabilities()
    --
    --     -- nvim-cdmp supports additional completion capabilities
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

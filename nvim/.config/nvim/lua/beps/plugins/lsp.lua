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
-- local signs = { Error = "🤬", Warn = "🖐️", Hint = "☝️", Info = "🤓" , Other = "🤔"}
local signs = { Error = '', Warn = '', Info = '', Hint = '', Other = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { icon = icon, text = icon, texthl = hl, numhl = hl })
end

require("neodev").setup({ })

require("mason").setup()
require("mason-lspconfig").setup()

-- lspconfig
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    cmp_nvim_lsp.default_capabilities()
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
            completion = {
                callSnippet = "Replace"
            },
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

-- Use LspAttach autocommand to only map the following keys after the
-- language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLSPConfig', { clear = true }),
    callback = function(event)
        -- mapping key and description
        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Default mappings
        -- crn for rename
        -- crr for code actions
        -- gr for references
        -- <C-S> (in Insert mode) for signature help
        map('gr', require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        map('gi', require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations.")

        map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition.')

        map('K', vim.lsp.buf.hover, 'show hover information.')

        map('<leader>rn', vim.lsp.buf.rename, 'Buffer [r]e[n]ame')

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('<leader>k', vim.lsp.buf.signature_help, 'signature help')

        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end,
        --     optsDesc(ev, 'LSP buffer format'))

        map('<leader>lt', require('telescope.builtin').diagnostics, 'document diagnostics')

        map('<leader>ls', require('telescope.builtin').lsp_document_symbols, "[L]ist document [S]ymbols")

        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        map('<leader>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")

        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")

        map('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            '[W]orkspace [L]ist folders')

        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, "[T]oggle Inlay [H]ints")
        end
        -- if client.supports_method("textDocument/inlayHint") then
        --     vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        -- end
        --

    end,
})

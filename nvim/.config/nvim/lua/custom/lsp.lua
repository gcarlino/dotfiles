local signs = { Error = ' ', Warn = ' ', Info = ' ', Hint = ' ', Other = "" }
vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.INFO] = signs.Info,
            [vim.diagnostic.severity.HINT] = signs.Hint,
        }
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = true,
    }
})


local servers = {
    -- python lsp server
    basedpyright = {
        enabled = true
    },
    pylsp = {
        enabled = false,
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
    },
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                runtime = { version = 'LuaJIT', },
                -- Get the language server to recognize the `vim` global
                diagnostics = {
                    globals = { 'vim' },
                    -- disable = { "missing-fields" },
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = { enable = false, },
                hint = { enable = true },
            },
        },
    },
    texlab = {},
    clangd = {},
    cmake = {},
    fortls = {
        filetypes = { 'fortran', 'fortran77' },
    },
    marksman = {},
    r_language_server = {},
    -- taplo = {},
}


-- Add border to some popup window
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
--   vim.lsp.handlers.hover, {
--     border = "single",
--   }
-- )
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help, {
--     border = "single",
--   }
-- )
--
-- require('lspconfig.ui.windows').default_options = {
--   border = "single",
-- }

-- lspconfig
-- Use LspAttach autocommand to only map the following keys after the
-- language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nvim-lsp-config', { clear = true }),
    callback = function(event)
        -- mapping key and description in normal mode
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Default mappings
        -- grn for rename
        -- gra for code actions
        -- grr for references
        -- <C-S> (in Insert mode) for signature help

        -- Disabled because of default keymap 'grr'
        -- map('gr', require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        map('gi', require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations.")

        map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition.')

        map('K', vim.lsp.buf.hover, 'Hover information.')

        -- Disabled because of default keymap `grn`
        -- map('<leader>rn', vim.lsp.buf.rename, 'Buffer [r]e[n]ame')

        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- map('<leader>k', vim.lsp.buf.signature_help, 'signature help')

        -- Disabled because of default keymap `gra`
        map('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        map('<leader>lf', function() vim.lsp.buf.format { async = true } end, 'buffer [F]ormat')

        map('<leader>ld', require('telescope.builtin').diagnostics, 'document [D]iagnostics')

        map('<leader>ls', require('telescope.builtin').lsp_document_symbols, "[L]ist document [S]ymbols")

        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        map('<leader>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")

        map('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")

        map('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            '[W]orkspace [L]ist folders')

        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- if client and client.server_capabilities.documentHighlightProvider then
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("nvim-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('nvim-lwp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'nvim-lsp-highlight', buffer = event2.buf }
                end,
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
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

vim.api.nvim_create_autocmd("LspDetach", {
    group = vim.api.nvim_create_augroup("nvim-lsp-detach", { clear = true }),
    callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "nvim-lsp-highlight", buffer = event.buf })
    end,
})

require("mason").setup()

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
        end
    }
})

-- local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
-- local signs = { Error = 'E', Warn = 'W', Info = 'I', Hint = 'H', Other = "O" }
vim.diagnostic.config({
    virtual_text = false,
    -- signs = {
    --     text = {
    --         [vim.diagnostic.severity.ERROR] = signs.Error,
    --         [vim.diagnostic.severity.WARN] = signs.Warn,
    --         [vim.diagnostic.severity.INFO] = signs.Info,
    --         [vim.diagnostic.severity.HINT] = signs.Hint,
    --     }
    -- },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = true,
    }
})

local servers = {
    basedpyright = {
        analysis = {
            typeCheckingMode = false,
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                completion = { callSnippet = "Replace" },
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
}

require("lspconfig").r_language_server.setup{}

-- Use LspAttach autocommand to only map the following keys after the
-- language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nvim-lsp-config', { clear = true }),
    callback = function(event)
        -- mapping key and description in normal mode
        local set = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        set('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Default mappings
        -- grn for rename
        -- gra for code actions
        -- grr for references
        -- gri for implementation
        -- gO in Normal mode maps to vim.lsp.buf.document_symbol()
        -- <C-S> (in Insert mode) for signature help

        -- Disabled because of default keymap 'grr'
        -- map('gr', require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        set('gi', require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementations.")

        set('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition.')

        set('K', vim.lsp.buf.hover, 'Hover information.')

        -- Disabled because of default keymap `grn`
        -- map('<leader>rn', vim.lsp.buf.rename, 'Buffer [r]e[n]ame')

        set('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- map('<leader>k', vim.lsp.buf.signature_help, 'signature help')

        -- Disabled because of default keymap `gra`
        set('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        set('<leader>lf', function() vim.lsp.buf.format { async = true } end, 'buffer [F]ormat')

        set('<leader>ld', require('telescope.builtin').diagnostics, 'document [D]iagnostics')

        set('<leader>ls', require('telescope.builtin').lsp_document_symbols, "[L]ist document [S]ymbols")

        set("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        set('<leader>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd folder")

        set('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove folder")

        set('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            '[W]orkspace [L]ist folders')

        -- Get the client by id
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Enable LSP folding if the LSP supports it
        -- (default is folding with treesitter)
        if client and client.server_capabilities.foldingRangeProvider then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end

        -- Enable inlay hints if the language server supports them
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            set("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle Inlay [H]ints")
        end
    end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)

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

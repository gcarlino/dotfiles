local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({

    -- completion = {
    --     completeopt = "menu, menuone, noselect",
    -- },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        -- { name = "dap" },
        { name = "cmp_r"},
    },
    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-a>"] = cmp.mapping.abort(),

        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-y>"] = cmp.mapping.confirm { select = true },

        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),

    }),
    -- nvim-cmp by defaults disables autocomplete for prompt buffers
    enabled = function()
        -- return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
        -- return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
        --     or require("cmp_dap").is_dap_buffer()
    end,
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            menu = ({
                buffer = '[Buf]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
                path = '[Path]',
                cmdline = '[Cmd]',
                cmp_r = '[R]'
            }),
            ellipsis_char = '...',
        }),
    },
    view = {
        entries = 'custom'
    },
    experimental = {
        native_menu = false,
        ghost_text = true
    }

})

-- Use
cmp.setup.filetype({ 'markdown', 'text', 'yaml' }, {
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        {
            name = "latex_symbols",
            option = {
                strategy = 0, -- show the command and insert the symbol
                -- strategy = 2, -- show and insert the command
            }
        },
        { name = 'buffer' },
        { name = 'path' }
    })
})

-- cmp.setup.filetype({'html'}, {
--     sources = cmp.config.sources({
--         { name = 'luasnip' },
--         { name = 'path' },
--         { name = 'buffer' },
--     })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path', },
        {
            name = 'cmdline',
            ignore_cmds = { 'Man', '!' }
        },
    })
})

-- hrsh7th/nvim-cmp
local status, cmp = pcall(require, 'cmp')
if not status then
    return
end
local lstatus, luasnip = pcall(require, 'luasnip')
if not lstatus then
    return
end

local lspkind = require('lspkind')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
        { name = "cmdline" },
        { name = "latex_symbols" },
        { name = "dap" },
        { name = "cmp_nvim_r" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end),
    }),
    -- nvim-cmp by defaults disables autocomplete for prompt buffers
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[Luasnip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
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
cmp.setup.filetype({ 'markdown', 'text' }, {
    sources = cmp.config.sources({
        { name = 'latex_symbols' },
        { name = 'buffer' },
        { name = 'path', keyword_length = 3}
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer', keyword_length = 3 }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path', keyword_length = 3 },
        { name = 'cmdline', keyword_length = 2 }
    })
})

-- Load snippets
require('luasnip.loaders.from_vscode').lazy_load()
-- }}}

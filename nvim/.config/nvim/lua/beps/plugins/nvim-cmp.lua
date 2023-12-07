-- hrsh7th/nvim-cmp
-- local status, cmp = pcall(require, 'cmp')
-- if not status then
--     return
-- end
-- local lstatus, luasnip = pcall(require, 'luasnip')
-- if not lstatus then
--     return
-- end
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    completion = {
        completeopt = "menu, menuone, noselect",
    },
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
        -- { name = "cmdline" },
        {
            name = "latex_symbols",
            option = {
                strategy = 0, -- show the command and insert the symbol
                -- strategy = 2, -- show and insert the command
            }
        },
        -- { name = "dap" },
        { name = "cmp_nvim_r" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ['<CR>'] = cmp.mapping.confirm({
            behaviour = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
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
        end, { 'i', 's' }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    -- nvim-cmp by defaults disables autocomplete for prompt buffers
    enabled = function()
        -- return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
        -- return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
        --     or require("cmp_dap").is_dap_buffer()
    end,
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            menu = ({
                buffer = '[Buf]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snip]',
                nvim_lua = '[Lua]',
                latex_symbols = '[Latex]',
                path = '[Path]',
                cmdline = '[Cmd]',
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
        { name = "nvim_lsp" },
        { name = 'latex_symbols' },
        { name = 'buffer' },
        { name = 'path', keyword_length = 3}
    })
})

cmp.setup.filetype({'html'}, {
    sources = cmp.config.sources({
        { name = 'luasnip', keyword_length = 1 },
        { name = 'path', keyword_length = 3 },
        { name = 'buffer' },
    })
})

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
        {
            name = 'path',
            keyword_length = 3
        },
        {
            name = 'cmdline',
            ignore_cmds = { 'Man', '!' }
        },
        {
            name = 'buffer',
            keyword_length = 3
        }
    })
})

-- Load snippets
-- require('luasnip.loaders.from_vscode').lazy_load()
-- }}}

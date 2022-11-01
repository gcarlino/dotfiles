-- hrsh7th/nvim-cmp {{{
local lspkind = require('lspkind')
lspkind.init()

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- set completeopt=menu,menuone,noselect
vim.opt.completeopt = 'menu,menuone,noselect'

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        -- { name = "cmdline" },
        { name = "latex_symbols" },
        { name = "dap" },
        { name = "buffer", keyword_length = 3 }
    }),

    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer        = "[buf]",
                nvim_lsp      = "[LSP]",
                nvim_lua      = "[lua]",
                path          = "[path]",
                luasnip       = "[snip]",
                latex_symbols = "[Latex]",
                cmdline       = "[cmd]",
            },
        }),
    },

    -- view = {
    --     entries = "native"
    -- },
    experimental = {
        native_menu = false,
        ghost_text = true
    }
})

cmp.setup.filetype({'markdown', 'text'}, {
    sources = cmp.config.sources({
        {name = 'latex_symbols'},
        {name = 'buffer'}
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer',
            keyword_length = 3
        }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline',
            keyword_length = 2 }
    })
})

-- Load snippets
require('luasnip.loaders.from_vscode').lazy_load()
-- }}}


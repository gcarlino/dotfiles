local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

cmp.setup({

    sources = {
        { name = "nvim_lsp" },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = "buffer" },
        { name = "path",
            option = {
                get_cwd = function ()
                    return vim.uv.cwd()
                end
            },
        },
        { name = "cmp_r" },
        { name = 'latex_symbols' },
        { name = 'vimtex' },
    },

    mapping =  {
        ["<C-n>"] = cmp.mapping.select_next_item{ behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item{ behavior = cmp.SelectBehavior.Insert },
        ["<C-a>"] = cmp.mapping.abort(),
        -- Accept the completion.
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.SelectBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),

        -- Manually trigger a completion from nvim-cmp.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),
    },

    -- Enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- nvim-cmp by defaults disables autocomplete for prompt buffers
    -- enabled = function()
    --     -- return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
    --     return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
    --     -- return vim.api.nvim_get_option_value("buftype", {buf = 0}) ~= "prompt"
    --     --     or require("cmp_dap").is_dap_buffer()
    -- end,

    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            menu = ({
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                latex_symbols = '[Latex]',
                path = '[Path]',
                cmdline = '[Command]',
                cmp_r = '[RStats]',
                vimtex = '[vimtex]',
            }),
            ellipsis_char = '...',
        }),
    },
})

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

cmp.setup.filetype({ 'tex' }, {
    sources = {
        { name = 'vimtex' },
        {
            name = 'latex_symbols',
            option = {
                strategy = 2,
            },
        },
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'path' }
    }
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
        { name = 'path', },
        {
            name = 'cmdline',
            ignore_cmds = { 'Man', '!' }
        },
    })
})

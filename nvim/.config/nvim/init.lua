require("beps.options")

-- Remap space as leader key and ; as local leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- Mac spefic configuration
if vim.fn.has("mac") == 1 then
    require("beps.mac")
end

require("beps.keymaps")
require("beps.disable_builtin")

require("beps.plugins-setup")


-- lewis6991/impatient.nvim 
require('impatient')

require('beps.colorscheme')
require('beps.plugins.treesitter')
require('beps.plugins.telescope')
require('beps.plugins.dap')


-- kyazdani42/nvim-web-devicons {{{
require('nvim-web-devicons').setup {
    default = true,
}
-- }}}


-- alvarosevilla95/luatab.nvim {{{
require('luatab').setup {}
-- }}}


-- statusline {{{
-- hoob3rt/lualine.nvim
require("beps.plugins.lualine")


-- lukas-reineke/indent-blankline.nvim {{{
require("indent_blankline").setup {
    show_current_context = true,
    -- show_current_context_start = true,
    show_end_of_line = true,
}
-- }}}


-- lewis6991/gitsigns.nvim {{{
require('gitsigns').setup {
    signs     = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns: stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns: reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer, { desc = "Gitsigns: stage buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Gitsigns: undo stage hunk" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "Gitsigs: reset buffer" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Gitsigns: preview hunk" })
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Gitsigns: blame line" })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Gitsigns: toggle current line blame" })
        map('n', '<leader>hd', gs.diffthis, { desc = "Gitsigns: diff this" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Gitsigns: diff this against last commit" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "Gitsign:  toggle deleted" })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
-- }}}


-- use akinsho/toggleterm.nvim {{{
require("toggleterm").setup {
    open_mapping = [[<c-q>]],
}

-- Mappings to make moving in and out of a terminal easier once toggled,
-- whilst still keeping it open
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- }}}


-- LSP {{{
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>di', function() require('telescope.builtin').diagnostics() end,
    { desc = "Document diagnostics" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, keymapOpts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
    { desc = "Add buffer diagnostic to the location list" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)

--     -- Trigger completion with <c-x><c-o>
        -- vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local bufopts = { buffer = args.buf, noremap = true, silent = true }

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
            { desc = "Jumps to the definition of the type of the symbol under the cursor." })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
            { desc = "Renames all references to the symbol under the cursor." })
        vim.keymap.set('n', '<leader>so',
            function()
                require('telescope.builtin').lsp_document_symbols()
            end,
            { desc = "Lists LSP symbols in the current buffer" })

        -- additional capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- nvim-cmp supports additional completion capabilities
        -- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- -- tell the sever the capability of foldingRange
        -- capabilities.textDocument.foldingRange = {
        --     dynamicRegistration = false,
        --     lineFoldingOnly = true
        -- }

    end
})

-- -- additional capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- -- nvim-cmp supports additional completion capabilities
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--
-- -- -- tell the sever the capability of foldingRange
-- -- capabilities.textDocument.foldingRange = {
-- --     dynamicRegistration = false,
-- --     lineFoldingOnly = true
-- -- }

-- }}}


-- j-hui/fidget.nvim {{{
require "fidget".setup {}
-- }}}


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


-- kyazdani42/nvim-tree.lua {{{
require('nvim-tree').setup()
-- }}}


-- chentoast/marks.nvim {{{
require 'marks'.setup({})
-- }}}


-- kevinhwang91/nvim-ufo {{{
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds." })
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds." })
--
local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

-- global handler
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end,
    fold_virt_text_handler = handler
})
-- }}}


-- jalvesazq/Nvim-R {{{
vim.cmd([[
    let R_assign_map = '<M-->'
    let rout_follow_colorscheme = 1
    let r_syntax_folding = 1
    set nofoldenable
    autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
]])
-- }}}


-- windwp/nvim-autopairs {{{
require('nvim-autopairs').setup({})
-- }}}


-- numToStr/Comment.nvim {{{
require('Comment').setup()

vim.keymap.set('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end,
    { desc = "Toggle comment on current line" })
vim.keymap.set('x', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
    { desc = "Toggle comment on current line" })
-- }}}


-- kylechui/nvim-surround {{{
require('nvim-surround').setup({})
-- }}}


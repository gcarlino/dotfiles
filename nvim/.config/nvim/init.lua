-- General options {{{
local keymapOpts = { noremap = true, silent = true }

-- Remap space as leader key and ; as local leader
-- vim.api.nvim_set_keymap('', '<Space>', '<Nop>', keymapOpts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the text line of the cursor
vim.opt.cursorline = true

-- Enable break indent
vim.opt.breakindent = true
-- Case insensitive search unless /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 4
vim.o.diffopt = 'internal,filler,closeoff,vertical'

-- Copy to system clipboard
vim.api.nvim_set_option('clipboard', 'unnamed')

-- Highlight syntax inside markdown
vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'r', 'sh' }

-- Switch to old filetype.vim mechanism
-- vim.g.do_legacy_filetype = 1
-- }}}


-- Plugins {{{

-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    Packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Tree-sitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- LSP
    -- Installati a mano i server di:
    --   R       install.packages("languageserver")
    --   Python:  npm install -g pyright / pip install pyright
    --   Fortran: pip install -U fortran-language-server
    --   HTML    npm install -g vscode-langservers-extracted
    --   YAML    brew install yaml-language-server
    --   BASH    brew install bash-language-server
    --   LUA     brew install lua-language-server
    --   LATEX   brew install texlab
    --   cmake   pip3 install cmake-language-server
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use {'nvim-telescope/telescope-ui-select.nvim' }
    -- Standalone UI for nvim-lsp progress
    use 'j-hui/fidget.nvim'

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-cmdline',
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'kdheepak/cmp-latex-symbols', after = 'nvim-cmp' },
            'rcarriga/cmp-dap'
        },
        -- config = [[require('config.cmp')]],
        -- event = 'InsertEnter *',
    }

    -- Snippet
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Telescope
    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    use { 'kyazdani42/nvim-tree.lua' }
    use { 'nvim-telescope/telescope-packer.nvim' }
    use { 'sudormrfbin/cheatsheet.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope.nvim' },
        }
    }

    -- Statusline & tabline
    use { 'alvarosevilla95/luatab.nvim',
        requires = 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- Folding
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    -- Git
    use { 'tpope/vim-fugitive' }
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- R
    use { 'jalvesaq/Nvim-R' }

    -- Debug
    use 'mfussenegger/nvim-dap'
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use 'mfussenegger/nvim-dap-python'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

    -- Color schemes
    use 'https://github.com/sainnhe/edge'

    -- Comment
    use 'numToStr/Comment.nvim'

    -- Various
    use 'rcarriga/nvim-notify'
    use 'windwp/nvim-autopairs'
    use 'chentoast/marks.nvim'
    use { 'akinsho/toggleterm.nvim', tag = 'v2.*' }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mechatroner/rainbow_csv'
    use 'adamheins/vim-highlight-match-under-cursor'
    use 'kylechui/nvim-surround'
    use { 'sidebar-nvim/sidebar.nvim', disable = true }
    use 'https://github.com/godlygeek/tabular'
    use { "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    -- Mac specific
    if vim.fn.has('mac') == 1 then
        use({'mrjones2014/dash.nvim',
            requires = { 'nvim-telescope/telescope.nvim' },
            run = 'make install', })
    end

    if Packer_bootstrap then
        require('packer').sync()
    end
end
)

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = 'init.lua'
})
-- }}}


-- Various {{{
-- Edit config file
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>', { desc = "Edit init.lua" })

-- No highlight
vim.keymap.set('n', '<CR>', ':noh<CR>', { desc = "No highlight" })

-- Move in split navigations
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Move lines around
vim.api.nvim_set_keymap('n', '<M-k>', ':m .-2<CR>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-j>', ':m .+1<CR>==', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-j>', '<ESC>:m .+1<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-k>', '<ESC>:m .-2<CR>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<M-j>', ":m '>+1<CR>gv==gv", { noremap = true })
vim.api.nvim_set_keymap('v', '<M-k>', ":m '<-2<CR>gv==gv", { noremap = true })

-- Change current directory to working file path
vim.keymap.set('n', '<leader>cd', '<cmd>cd %:p:h<CR>:pwd<CR>',
    { noremap = true, silent = true, desc = "Change current directory to working file path." })

-- Highlight on yank
local yankHighlightGroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = yankHighlightGroup,
    pattern = "*"
})

-- Quickfixlist navigation
vim.keymap.set("n", "]q", ":cnext<cr>", { desc = "Next item in quickfix list" })
vim.keymap.set("n", "[q", ":cnext<cr>", { desc = "Previous item in quickfix list" })

-- listchars
vim.opt.listchars = {
    tab = '▸ ',
    trail = '·',
    precedes = '←',
    extends = '→',
    conceal = '┊',
    eol = '↲',
    nbsp = '␣'
}

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    callback = function()
        vim.opt.list = true
    end
})
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "InsertLeave" }, {
    pattern = "*",
    callback = function()
        vim.opt.list = false
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "html",
    callback = function()
        vim.o.tabstop = 2
        vim.o.shiftwidth = 2
    end
})

-- Fold method for init.lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.o.foldmethod = "marker"
        vim.o.foldlevel = 0
        vim.opt.foldcolumn = "1"
    end
})
-- }}}


-- Set colors {{{
vim.o.termguicolors = true

-- sainnhe/edge
vim.g.edge_style = 'aura'
vim.g.edge_better_performance = 1
vim.g.edge_dim_foreground = 1
vim.g.edge_disable_italic_comment = 1
vim.g.edge_disable_terminal_colors = 1
vim.cmd([[ colorscheme edge ]])

-- -- Override split separator color
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#666666' })

-- Toggle backgournd color 
vim.api.nvim_set_keymap("n", "<leader>b", "", {
    noremap = true,
    callback = function()
        local _background = vim.api.nvim_get_option("background")
        if (_background == "light") then
            vim.o.background = "dark"
        else
            vim.o.background = "light"
        end
    end,
    desc = "Toggle background color"
})
-- }}}


-- kyazdani42/nvim-web-devicons {{{
require('nvim-web-devicons').setup {
    default = true,
}
-- }}}


-- Tree-sitter {{{
-- Parsers must be installed manually via :TSInstall
require 'nvim-treesitter.configs'.setup({
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
})
-- Tree-sitter base folding
vim.cmd[[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]]
-- }}}


-- alvarosevilla95/luatab.nvim {{{
require('luatab').setup {}

vim.keymap.set("n", "]t", ":tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[t", ":tabprevious<cr>", { desc = "Previous tab"})
-- }}}


-- statusline {{{
-- hoob3rt/lualine.nvim
require("beps.lualine")

-- Global window status line
vim.opt.laststatus = 3
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dapui*", "dap-repl" },
    callback = function()
        vim.opt.laststatus = 2
    end
})

-- Hide command line when it is not used
-- -- if vim.fn.has("gui_vimr") ~= 1 then
-- --     vim.cmd([[set cmdheight=0]])
-- -- end
--
-- --[[ -- winbar
-- if vim.fn.has("gui_vimr") ~= 1 then
--     vim.opt.winbar = "%= %m %t"
-- end ]]
-- }}}


-- lukas-reineke/indent-blankline.nvim {{{
require("indent_blankline").setup {
    show_current_context = true,
    -- show_current_context_start = true,
    show_end_of_line = true,
}
-- }}}


-- lewis6991/gitsigns.nvim {{{
require('gitsigns').setup {
    signs                             = {
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
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns: stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns: reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer, {desc = "Gitsigns: stage buffer"})
    map('n', '<leader>hu', gs.undo_stage_hunk, {desc = "Gitsigns: undo stage hunk"})
    map('n', '<leader>hR', gs.reset_buffer, {desc = "Gitsigs: reset buffer"})
    map('n', '<leader>hp', gs.preview_hunk, {desc = "Gitsigns: preview hunk"})
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc = "Gitsigns: blame line"})
    map('n', '<leader>tb', gs.toggle_current_line_blame, {desc = "Gitsigns: toggle current line blame"})
    map('n', '<leader>hd', gs.diffthis, {desc = "Gitsigns: diff this"})
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Gitsigns: diff this against last commit"})
    map('n', '<leader>td', gs.toggle_deleted, { desc = "Gitsign:  toggle deleted" })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
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
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- }}}


-- neovi/nvim-lspconfig {{{
-- local nvim_lsp = require 'lspconfig'

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
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = "Goto previous diagnostic"})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = "Goto next diagnostic"})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
    {desc = "Add buffer diagnostic to the location list"})

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Trigger completion with <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', bufopts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', bufopts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
        {desc = "Jumps to the definition of the type of the symbol under the cursor."})
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        {desc = "Renames all references to the symbol under the cursor."})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        {desc = "Selects a code action available at the current cursor position."})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.formatting, 
        {desc = "Format the current buffer"})
    vim.keymap.set('n', '<leader>so',
        function()
            require('telescope.builtin').lsp_document_symbols()
        end,
        {desc = "Lists LSP symbols in the current buffer"})
end

-- additional capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- nvim-cmp supports additional completion capabilities
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- tell the sever the capability of foldingRange
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Enable the following language servers
local servers = { 'pyright', 'html', 'r_language_server', 'yamlls', 'bashls', 'texlab', 'cmake' }
for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- custom server configurations
require('lspconfig').fortls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'fortls' },
    filetypes = { "fortran", "fortran77" },
    settings = {
        notifyInit = true,
        lowercaseIntrinsics = true,
        enableCodeActions = true
    }
}

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    cmd = { 'lua-language-server' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
-- }}}


-- j-hui/fidget.nvim {{{
require"fidget".setup{}
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
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback()
        --     end
        -- end),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif luasnip.jumpable(-1) then
        --         luasnip.jump(-1)
        --     else
        --         fallback()
        --     end
        -- end),
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
        { name = "cmdline" },
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

    experimental = {
        native_menu = false,
        ghost_text = true
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
local nvim_tree = require 'nvim-tree'
nvim_tree.setup()
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true })
-- }}}


-- chentau/marks.nvim {{{
require 'marks'.setup {
    -- whether to map keybinds or not. default true
    default_mappings = true,
    -- which builtin marks to show. default {}
    builtin_marks = { ".", "<", ">", "^" },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
    -- sign/virttext. Bookmarks can be used to group together positions and quickly move
    -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
    -- default virt_text is "".
    bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world"
    },
    mappings = {}
}
-- }}}


-- Fortran specific {{{
vim.api.nvim_create_autocmd("FileType", {
    pattern = "fortran",
    callback = function()
        vim.o.tabstop = 2
        vim.o.shiftwidth = 2
    end
})
--[[ vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
    pattern = "fortran77",
    callback = function ()
        vim.bo.syntax="fortran"
        vim.g.fortran_fixed_source=1
        vim.o.tabstop = 6
        vim.o.shiftwidth = 6
        vim.o.softtabstop=6
        vim.bo.commentstring = "C%s"
    end
}) ]]
-- }}}


-- kevinhwang91/nvim-ufo {{{
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds." })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds." })

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
    fold_virt_text_handler = handler
})

-- buffer scope handler
-- will override global handler if it is existed
local bufnr = vim.api.nvim_get_current_buf()
require('ufo').setFoldVirtTextHandler(bufnr, handler)
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


-- DAP {{{
-- Adapters configurations in beps/dap_config.lua

local dap = require("dap")
local dapui = require("dapui")

--- Python
-- vim.g.python3_host_prog = '~/.virtualenvs/debugpy/bin/python3'

-- nvim-dap-ui
dapui.setup({
    floating = {
        max_height = 0.95,
        max_width = 0.95,
    }
})

-- Breakpoint symbols
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = '', linehl = '', numhl = '' })

-- key mappings
-- Clear configurations, reload and continue
vim.keymap.set("n", "<leader>dd",
    function()
        require("beps.dap_config").clear_configurations()
        require("beps.dap_config").config_dap()
        dap.continue()
    end,
    { desc = "DAP: debug load configurations with Telescope" })

vim.keymap.set('n', '<F5>', function() dap.continue() end,
    { desc = "DAP: debug continue" })
vim.keymap.set('n', '<F4>', function() dap.run_last() end,
    { desc = "DAP: debug run last configuration" })
vim.keymap.set('n', '<F3>', function() dap.pause() end,
    { desc = "DAP: debug pause" })
vim.keymap.set('n', '<F2>', function () dap.terminate() end,
    { desc = "DAP: debug terminate" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end,
    { desc = "DAP: debug step over" })
vim.keymap.set('n', '<F11>', function() dap.step_into() end,
    { desc = "DAP: debug step into" })
vim.keymap.set('n', '<F12>', function() dap.step_out() end,
    { desc = "DAP: debug step out" })
vim.keymap.set('n', '<F8>', function() dap.run_to_cursor() end,
    { desc = "DAP: debug run to cursor" })
vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end,
    { desc = "DAP: debug toggle breakpoint" })
vim.keymap.set('n', '<leader>db', function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "DAP: debug set breakpoint condition" })
vim.keymap.set('n', '<leader>dx', function() dap.disconnect() end,
    { desc = "DAP: debug disconnect" })
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end,
    { desc = "DAP: debug open repl" })
vim.keymap.set('n', '<leader>dt', function() dapui.toggle({}) end,
    { desc = "DAP: debug toggle dap-ui" })
vim.keymap.set('n', '<leader>dc', function() dapui.close({}) end,
    { desc = "DAP: debug close dap-ui" })

-- hover
vim.keymap.set({'n', 'x'}, '<leader>i', function () dapui.eval(nil, {enter = true, context = "repl"}) end,
    { desc = "DAP: open a floating window containing the result of evaluting an expression" })

-- Reload launch json configuration
vim.keymap.set('n', '<leader>dl', function() require("dap.ext.vscode").load_launchjs("./.nvim-dap/launch.json") end,
    { desc = "DAP: load ./.nvim-dap/launch.json with debugger configuration" })

-- Use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

-- DAP virtual text
require("nvim-dap-virtual-text").setup({
    virt_text_win_col = 80,
})
-- }}}


-- numToStr/Comment.nvim {{{
require('Comment').setup()

vim.keymap.set('n', '<leader>/', function () require('Comment.api').toggle.linewise.current() end,
    { desc = "Toggle comment on current line" })
vim.keymap.set('x', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
    { desc = "Toggle comment on current line" })
-- }}}


-- "kylechui/nvim-surround {{{
require("nvim-surround").setup({})
-- }}}


-- Telescope {{{
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<M-v>'] = require('telescope.actions.layout').toggle_preview
            }
        },
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        layout_strategies = "flex",
        layout_config = {
            prompt_position = "top",
        },
    },
    preview = {
        hide_on_startup = false
    },
    extensions = {
        [ "ui-select" ] = {
            require("telescope.themes").get_dropdown()
        },
        file_browser = {
            respect_gitignore = false,
            hijack_netrw = true,
        },
    }
}

if vim.fn.has('mac') == 1 then
  require('telescope').setup {
    extensions = {
      dash = {
        file_type_keywords = {
          html = {'html', 'css', 'javascript', 'bootstrap'}
        }
      }
    }
  }

    require('telescope').load_extension('dash')
end

-- Load extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension 'file_browser'
require("telescope").load_extension("packer")
require("telescope").load_extension("ui-select")
require('telescope').load_extension('dap')

-- Keymaps
vim.keymap.set('n', '<leader>p', function() require('telescope.builtin').commands() end, {
    desc = "Lists available plugin/user commands and runs them on `<cr>`" })

vim.keymap.set('n', '<leader><space>', function() require('telescope.builtin').buffers() end, {
    desc = "Show buffers with Telescope" })

vim.keymap.set('n', '<leader>fs', function() require('telescope').extensions.file_browser.file_browser() end, {
    desc = "Telescope file browser" })

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, {
    desc = "Telescope find files" })

vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').current_buffer_fuzzy_find() end, {
    desc = "Telescope fuzzy find in current buffer" })

vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, {
    desc = "Telescope help" })

vim.keymap.set('n', '<leader>fw', function () require('telescope.builtin').grep_string() end, {
    desc = "Telescope searches for the string under your cursor in your current working directory" })

vim.keymap.set('n', '<leader>fg', function () require('telescope.builtin').live_grep() end, {
    desc = "Search for a string and get results live as you type." })

vim.keymap.set('n', '<leader>fk', function () require('telescope.builtin').keymaps() end, {
    desc = "See keymaps with Telescope" })

vim.keymap.set('n', '<leader>?', '<CMD>Cheatsheet<CR>', { desc = "Cheatsheet" })

-- Telescope for git
vim.keymap.set('n', '<leader>gc', function () require('telescope.builtin').git_commits() end, {
    desc = "Telescope lists commits for current directory with diff preview" })

vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end, {
    desc = "Telescope lists git status for current directory" })

vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_bcommits() end, {
    desc = "Telescope lists commits for current buffer with diff preview" })

-- Search dotfiles
vim.keymap.set('n', '<leader>ed',
    function()
        require('telescope.builtin').git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Edit dotfiles ~",
            layout_strategies = "horizontal",
        }
    end,
    { desc = "Telescope edit dotfiles" })

-- Telescope LSP commands
vim.keymap.set('n', '<leader>ls', function () require('telescope.builtin').lsp_references() end, {
    desc = "List LSP references for word under the cursor" })
-- }}}


-- rcarriga/nvim-notify {{{
vim.notify = require("notify")
-- }}}


-- Load mac specific configuration {{{
if vim.fn.has("mac") == 1 then
    require("beps.mac")
end
-- }}}

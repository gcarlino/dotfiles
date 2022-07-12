-- General setup {{{
local keymapOpts = { noremap = true, silent = true }

-- Remap space as leader key and ; as local leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', keymapOpts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the text line of the cursor
vim.opt.cursorline = true
-- Enable mouse mode
vim.opt.mouse = 'a'
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

--Save undo history
vim.opt.undofile = false

-- Copy to system clipboard
vim.api.nvim_set_option("clipboard", "unnamed")

-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
-- let g:do_filetype_lua = 1 and let g:did_load_filetypes = 0
-- }}}


-- Plugins {{{

-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    Packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
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

    -- Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'rcarriga/cmp-dap'
    use { 'hrsh7th/nvim-cmp',
        requires = { 'kdheepak/cmp-latex-symbols' } }

    -- Snippet
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use 'kyazdani42/nvim-tree.lua'
    use 'sudormrfbin/cheatsheet.nvim'

    -- Tabline
    use { 'alvarosevilla95/luatab.nvim', requires = 'kyazdani42/nvim-web-devicons' }

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Folding
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

    -- Git
    use 'tpope/vim-fugitive'
    -- use 'itchyny/vim-gitbranch'
    use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- use 'airblade/vim-gitgutter'
    use 'f-person/git-blame.nvim'

    -- R
    use 'jalvesaq/Nvim-R'

    -- Debug
    use "mfussenegger/nvim-dap"
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use 'mfussenegger/nvim-dap-python'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

    -- Color schemes
    use 'https://github.com/sainnhe/edge'

    -- Comment
    use 'numToStr/Comment.nvim'

    -- Various
    use 'szw/vim-maximizer'
    use 'windwp/nvim-autopairs'
    use 'simrat39/symbols-outline.nvim'
    use 'chentoast/marks.nvim'
    use { "akinsho/toggleterm.nvim" }
    -- use 'tpope/vim-unimpaired'
    -- use 'sbdchd/neoformat'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mechatroner/rainbow_csv'
    use 'adamheins/vim-highlight-match-under-cursor'
    use 'tpope/vim-surround'
    -- use 'tjdevries/astronauta.nvim'
    use 'sidebar-nvim/sidebar.nvim'
    use 'https://github.com/godlygeek/tabular'

    -- Mac specific
    if vim.fn.has('mac') == 1 then
        use 'rizzatti/dash.vim'
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
vim.api.nvim_set_keymap('n', '<leader>v', ':e $MYVIMRC<CR>', keymapOpts)

-- No highlight
vim.api.nvim_set_keymap('n', '<CR>', ':noh<CR>', keymapOpts)

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
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', { noremap = true })

-- Highlight syntax inside markdown
vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'r', 'sh' }

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
vim.api.nvim_set_keymap("n", "]q", ":cnext<cr>", keymapOpts)
vim.api.nvim_set_keymap("n", "[q", ":cprevious<cr>", keymapOpts)
-- }}}


-- listchars {{{
vim.opt.listchars = {
    tab = '▸ ',
    trail = '·',
    precedes = '←',
    extends = '→',
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
-- }}}


-- Set colors {{{
vim.o.termguicolors = true

-- sainnhe/edge
vim.g.edge_style = 'aura'
vim.g.edge_enable = 1
-- -- vim.g.edge_enable_italic = 1
vim.g.edge_disable_italic_comment = 1
vim.g.edge_better_performance = 1
vim.cmd([[ colorscheme edge ]])
-- }}}


-- kyazdani42/nvim-web-devicons {{{
require('nvim-web-devicons').setup{
    default = true,
}
-- }}}


-- Tree-sitter configuration {{{
-- Parsers must be installed manually via :TSInstall
require 'nvim-treesitter.configs'.setup({
    highlight = {
        enable = true, -- false will disable the whole extension
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
            enable = false,
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
-- }}}


-- alvarosevilla95/luatab.nvim {{{
require('luatab').setup {}

vim.api.nvim_set_keymap("n", "]t", ":tabnext<cr>", keymapOpts)
vim.api.nvim_set_keymap("n", "[t", ":tabprevious<cr>", keymapOpts)
-- }}}


-- hoob3rt/lualine.nvim {{{
-- Get current working directory (relative to home path)
local function getCWD()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

require 'lualine'.setup {
    extensions = {'nvim-tree', 'toggleterm', 'nvim-dap-ui', 'fugitive', 'symbols-outline'},
    options = {
        theme = 'edge',
        global = true,
        section_separators = { left = '', right = '' },
        component_separators = ""
    },
    sections = {
        lualine_c = {
            { getCWD },
            '%=',
            {
                'filetype',
                icon_only = true
            },
            {
                'filename',
                file_status = true,
                path = 1,
            },
        },
        lualine_x = {'encoding', 'fileformat'},
    },
}

-- Global window status line
vim.opt.laststatus = 3

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dapui*", "dap-repl" },
    callback = function()
        vim.opt.laststatus = 2
    end
})

-- Hide command line when it is not used
if vim.fn.has("gui_vimr") ~= 1 then
    vim.cmd([[set cmdheight=0]])
end

--[[ -- winbar
if vim.fn.has("gui_vimr") ~= 1 then
    vim.opt.winbar = "%= %m %t"
end ]]
-- }}}


-- Toggle color {{{
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
    signcolumn                        = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl                             = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                            = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                         = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                      = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked               = true,
    current_line_blame                = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts           = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false
    },
    sign_priority                     = 6,
    update_debounce                   = 100,
    status_formatter                  = nil, -- Use default
    max_file_length                   = 40000,
    preview_config                    = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                              = {
        enable = false
    },
}
-- }}}


-- szw/vim-maximizer {{{
vim.api.nvim_set_keymap('n', '<leader>m', ':MaximizerToggle!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-W><C-m>', ':MaximizerToggle!<CR>', { noremap = true })
-- }}}


-- kassio/neoterm {{{
vim.g.neoterm_default_mod = 'belowright'
vim.g.neoterm_size = 18
vim.g.neoterm_autoinsert = 1
vim.api.nvim_set_keymap('n', '<c-q>', ":<c-u>exec v:count.'Ttoggle'<CR>", { noremap = true })
vim.api.nvim_set_keymap('i', '<c-q>', '<Esc>:Ttoggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<c-q>', '<c-\\><c-n>:Ttoggle<CR>', { noremap = true })
-- }}}


-- use akinsho/toggleterm.nvim {{{
require("toggleterm").setup {
    open_mapping = [[<c-q>]],
}
-- }}}


-- sbdchd/neoformat {{{
-- vim.api.nvim_set_keymap('n', '<leader>F', ':Neoformat prettier<CR>', { noremap = true })
-- }}}


-- GustavoKatel/sidebar.nvim {{{
require("sidebar-nvim").setup({
    sections = { "datetime", "buffers", "git", "symbols", "todos", "diagnostics" },
    hide_statusline = true,
    section_separator = {"", "–––––––––––––––––––––––––––––"},
    datetime = {
        clocks = {
            { name = "Local"}
        }
    },
    buffers = {
        ignored_buffers = {"SidebarNvim*"}
    }
})

-- nnoremap <leader>sb <cmd>SidebarNvimToggle<CR>
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>SidebarNvimToggle<CR>', { noremap = true })
-- }}}


-- nvim-telescope/telescope {{{
-- local actions = require('telescope.actions')
-- local action_layout = require('telescope.actions.layout')

require('telescope').setup {
    defaults = {
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        layout_strategies = "flex",
        layout_config = {
            prompt_position = "top",
        },
    },
    extensions = {
        file_browser = {
            respect_gitignore = false,
            hijack_netrw = true,
        }
    }
}

-- nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')
-- nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>Telescope commands<cr>', keymapOpts)

vim.api.nvim_set_keymap('n', '<leader><space>', '<cmd>Telescope buffers<cr>', keymapOpts)

vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>Telescope file_browser<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>sf', '<cmd>Telescope find_files<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>sw', '<cmd>Telescope grep_string<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>sg', '<cmd>Telescope live_grep<cr>', keymapOpts)

-- vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
-- vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
-- vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

-- Telescope for git
vim.api.nvim_set_keymap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>Telescope git_bcommits<cr>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>gs', '<cmd>Telescope git_status<cr>', keymapOpts)

-- Search dotfiles
vim.api.nvim_set_keymap('n', '<leader>ed', "", {
    callback = function()
        require('telescope.builtin').git_files {
            cwd = "~/.dotfiles/",
            prompt_title = "~ Edit dotfiles ~",
            layout_strategies = "horizontal",
        }
    end
})


-- Telescope LSP commands

-- nnoremap <leader>ls <cmd>lua require('telescope.builtin').lsp_references()<cr>
-- vim.api.nvim_set_keymap('n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], {noremap = true})
-- }}}

-- neovi/nvim-lspconfig {{{
local nvim_lsp = require 'lspconfig'

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
vim.api.nvim_set_keymap('n', '<leader>di', '<cmd>Telescope diagnostics<cr>', keymapOpts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float, keymapOpts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymapOpts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymapOpts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymapOpts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', keymapOpts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], keymapOpts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- tell the sever the capability of foldingRange
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
--

-- Enable the following language servers
local servers = { 'pyright', 'html', 'r_language_server', 'yamlls', 'bashls', 'texlab', 'cmake' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- custom server configurations
require('lspconfig').fortls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'fortls' },
    filetypes = { "fortran", "Fortran77" },
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
    enabled = function ()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "cmdline" },
        { name = "latex_symbols" },
        { name = "dap"},
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


-- Fold method for init.lua {{{
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.o.foldmethod = "marker"
        vim.o.foldlevel = 0
        vim.opt.foldcolumn = "1"
    end
})
-- }}}


-- Fortran specific {{{
vim.cmd([[
    augroup Fortran77
    autocmd!
    autocmd BufNewFile,BufRead *.f :set filetype=Fortran77
    autocmd BufNewFile,BufRead *.f :set syntax=fortran
    autocmd Filetype Fortran77 let g:fortran_fixed_source=1
    autocmd Filetype Fortran77 set tabstop=6
    autocmd Filetype Fortran77 set softtabstop=3
    autocmd Filetype Fortran77 set shiftwidth=3
    augroup end
    doautoall Fortran77 FileType Loaded-Buffer,BufRead

    augroup customFortran
    autocmd FileType fortran setlocal tabstop=2
    autocmd FileType fortran setlocal shiftwidth=2 
    augroup end

    augroup FortranCUDA
      autocmd!
      autocmd BufNewFile,BufRead *.cuf :set filetype=fortran
    augroup end
]])
vim.api.nvim_set_keymap('n', '<leader>ff', ':set syntax=fortran<CR>', keymapOpts)
-- }}}


-- kevinhwang91/nvim-ufo {{{
vim.wo.foldcolumn = '1'
vim.wo.foldlevel = 99 -- feel free to decrease the value
vim.wo.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

require('ufo').setup()
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
-- Adapters configurations in dap_config.lua

local dap = require("dap")
local dapui = require("dapui")

--- Python
-- vim.g.python3_host_prog = '~/.virtualenvs/debugpy/bin/python3'

-- Enable dap in telescope
require('telescope').load_extension('dap')

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
vim.api.nvim_set_keymap("n", "<leader>dd", "", {
    noremap = true,
    callback = function()
        require("dap_config").clear_configurations()
        require("dap_config").config_dap()
        dap.continue()
    end,
    }
)
vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("dap").continue()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("dap").run_last()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua require("dap").pause()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F2>', '<Cmd>lua require("dap").terminate()<CR>', keymapOpts)

vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require("dap").step_over()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require("dap").step_into()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require("dap").step_out()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F8>', '<Cmd>lua require("dap").run_to_cursor()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<F9>', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>b', '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', keymapOpts)

vim.api.nvim_set_keymap('n', '<leader>dx', '<Cmd>lua require("dap").disconnect()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>dr', '<Cmd>lua require("dap").repl.open()<CR>', keymapOpts)

vim.api.nvim_set_keymap('n', '<leader>dt', '<Cmd>lua require("dapui").toggle()<CR>', keymapOpts)
vim.api.nvim_set_keymap('n', '<leader>dc', '<Cmd>lua require("dapui").close()<CR>', keymapOpts)


-- hover
-- vim.api.nvim_set_keymap('n', '<leader>f', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>i', '<Cmd>lua require("dapui").eval(nil, {enter = true, context = "repl"})<CR>', keymapOpts)
vim.api.nvim_set_keymap('x', '<leader>i', '<Cmd>lua require("dapui").eval(nil, {enter = true, context = "repl"})<CR>', keymapOpts)

 -- Reload launch json configuration
vim.api.nvim_set_keymap('n', '<leader>dl', '<Cmd>lua require("dap.ext.vscode").load_launchjs("./.nvim-dap/launch.json")<cr>', {noremap = true, silent = false})

-- Use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- DAP virtual text
require("nvim-dap-virtual-text").setup({
    virt_text_win_col = 80,
})
-- }}}


-- f-person/git-blame.nvim {{{
-- Disable by default. Toggle with :GitBlameToggle
vim.g.gitblame_enabled = 0
-- }}}


-- numToStr/Comment.nvim {{{
require('Comment').setup()

vim.keymap.set('n', '<leader>/', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
vim.keymap.set('x', '<leader>/', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Fortran77
require('Comment.ft').set('Fortran77', 'C%s')
-- }}}


-- Load mac specific configuration {{{
if vim.fn.has("mac") == 1 then
    require("bepsmac")
    -- Simularia notes
    vim.api.nvim_set_keymap('n', '<leader>sn', '<cmd>lua require("bepsmac").simulnotes()<cr>', keymapOpts)
end
-- }}}

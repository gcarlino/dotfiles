-- General setup {{{
local opts = { noremap = true, silent = true }

-- Remap space as leader key and ; as local leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', opts)
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

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

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
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use 'mfussenegger/nvim-dap-python'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'


    -- Color schemes
    use 'https://github.com/sainnhe/edge'

    -- Tabline
    use { 'alvarosevilla95/luatab.nvim', requires = 'kyazdani42/nvim-web-devicons' }

    -- Various
    use 'szw/vim-maximizer'
    use 'windwp/nvim-autopairs'
    use 'simrat39/symbols-outline.nvim'
    use 'chentoast/marks.nvim'
    use { "akinsho/toggleterm.nvim" }
    use 'tpope/vim-commentary'
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
vim.api.nvim_set_keymap('n', '<leader>v', ':e $MYVIMRC<CR>', opts)

-- No highlight
vim.api.nvim_set_keymap('n', '<CR>', ':noh<CR>', opts)

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


-- Mac specific {{{
if vim.fn.has('mac') == 1 then
    vim.api.nvim_set_keymap('n', '<leader>gm', ':silent !open -a "Marked 2.app" %<CR>', { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>DashSearch', { silent = true })
end
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


-- alvarosevilla95/luatab.nvim {{{
require('luatab').setup {}
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

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- }}}


-- hoob3rt/lualine.nvim {{{
require 'lualine'.setup {
    options = {
        theme = 'edge'
    },
    extensions = { 'nvim-tree', 'toggleterm' }
}
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


-- tpope/vim-commentary {{{
vim.api.nvim_set_keymap('n', '<leader>/', ':Commentary<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':Commentary<CR>', { noremap = true })
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
vim.api.nvim_set_keymap('n', '<leader>F', ':Neoformat prettier<CR>', { noremap = true })
-- }}}


-- GustavoKatel/sidebar.nvim {{{
require("sidebar-nvim").setup({
    sections = { "datetime", "git", "symbols", "diagnostics" },
    hide_statusline = true,
})
-- nnoremap <leader>sb <cmd>SidebarNvimToggle<CR>
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>SidebarNvimToggle<CR>', { noremap = true })
-- }}}


-- nvim-telescope/telescope {{{
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

require('telescope').setup {
    defaults = {
        color_devicons = true,
        --     -- initial_mode = "insert",
        mappings = {
            i = {
                -- ["<c-x>"] = false,
                ["<C-/>"] = "which_key",
                ["<esc>"] = actions.close,
            },
        }
    },
    pickers = {
        git_files = {
            shorten_path = true,
            -- layout_strategy = "horizontal",
            -- layout_options = {
            -- preview_width = 0.75,
            -- },
        },
        -- buffers = {
        -- show_all_buffers = true,
        -- show_last_used = true,
        -- },
    },
    extensions = {
        file_browser = {
            respect_gitignore = false,
        }
    }
}

-- nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')
-- nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('telescope.builtin').commands()<CR>]], opts)

vim.api.nvim_set_keymap('n', '<leader>ss', "<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sw', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

-- Telescope for git
-- vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gh', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]], opts)


-- Search for Simularia notes
if vim.fn.has("mac") == 1 then
    vim.api.nvim_set_keymap("n", "<leader>sn", "", {
        noremap = true,
        callback = function()
            require('telescope.builtin').live_grep {
                -- path_display = "tail",
                cwd = "~/Simularia/Notes",
                prompt_title = "~ (Not only) Simularia Notes ~",
                layout_strategy = "horizontal",
            }
        end,
    })
end

-- Search nvim dotfiles
vim.api.nvim_set_keymap('n', '<leader>en', "", {
    callback = function()
        require('telescope.builtin').find_files {
            cwd = "~/.dotfiles/nvim/.config/nvim/",
            prompt_title = "~ Edit nvim ~",
            layout_strategies = "horizontal",
        }
    end
})

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

-- See `:help vim.lsp.*` for documentation on any of the below functions
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = 0})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ["<C-y"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
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
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "cmdline" },
        { name = "latex_symbols" },
        { name = "buffer", keyword_length = 3 }
    }),

    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[lua]",
                path = "[path]",
                luasnip = "[snip]",
                latex_symbols = "[Latex]",
                cmdline = "[cmd]",
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
        vim.opt.foldcolumn = "3"
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
    autocmd FileType Fortran77 setlocal commentstring=C\ %s
    autocmd Filetype Fortran77 let b:commentary_startofline=1
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
vim.api.nvim_set_keymap('n', '<leader>ff', ':set syntax=fortran<CR>', opts)
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

local dap, dapui = require("dap"), require("dapui")

-- Load configurations inside ./.nvim-dap/launch.json
require('dap.ext.vscode').load_launchjs('./.nvim-dap/launch.json')

--- Python DAP setup
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
vim.g.python3_host_prog = '~/.virtualenvs/debugpy/bin/python3'

-- C/C++/Rust (via vscode-cpptools)
dap.adapters.fortran = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/carlino/.vscode-server/extensions/ms-vscode.cpptools-1.9.7/debugAdapters/bin/OpenDebugAD7'
}

-- Enable dap in telescope
require('telescope').load_extension('dap')

-- nvim-dap-ui
require("dapui").setup({
    floating = {
        max_height = 0.85,
        max_width = 0.85,
    }
})

-- Diasbale statusline
vim.api.nvim_create_autocmd("FileType", {
    pattern = {'dap-repl', 'dapui*'},
    command = "set statusline="
})

-- key mappings
vim.api.nvim_set_keymap('n', '<leader>dd', '<Cmd>lua require("dap").continue()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("dap").continue()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("dap").run_last()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua require("dap").pause()<CR>', opts)

vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require("dap").step_over()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require("dap").step_into()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require("dap").step_out()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F8>', '<Cmd>lua require("dap").run_to_cursor()<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>dx', '<Cmd>lua require("dap").disconnect()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dr', '<Cmd>lua require("dap").repl.open()<CR>', opts)
vim.api.nvim_set_keymap('n', '<F9>', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })

-- hover
-- vim.api.nvim_set_keymap('n', '<leader>f', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', '<Cmd>lua require("dapui").eval(nil, {enter = true, context = "repl"})<CR>', opts)
vim.api.nvim_set_keymap('x', '<leader>e', '<Cmd>lua require("dapui").eval(nil, {enter = true, context = "repl"})<CR>', opts)

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

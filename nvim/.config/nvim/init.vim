"z General setup {{{
set completeopt=menu,menuone,noselect
set autoindent
set mouse=a
set splitright
set splitbelow
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set relativenumber
set number
set ignorecase
set smartcase
set incsearch
set diffopt+=vertical
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set signcolumn=yes
set updatetime=750
set scrolloff=4
set cursorline
" Do not insert two spaces after a '.', '?' and '!' with a join command.
set nojoinspaces
set showcmd
filetype plugin indent on

set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Default mapleader is \
let mapleader = " "
" }}}

" Plugins {{{
" vim-plug PlugInstall PlugClean PlugUpdate            
call plug#begin('~/.config/nvim/site/plugged')
    " PlugInstall PlugClean PlugUpdate
    "
    " LSP
    " Installati a mano i server di:
    "   R:       install.packages("languageserver")
    "   Python:  npm install -g pyright
    "   Fortran: pip install -U fortran-language-server
    "   HTML:    npm install -g vscode-langservers-extracted
    "   YAML:    npm install yaml-language-server
    "   BASH:    npm install bash-language-server
    Plug 'neovim/nvim-lspconfig'
    Plug 'onsails/lspkind-nvim'
    " Plug 'williamboman/nvim-lsp-installer'


    " Completion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/nvim-cmp'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'sudormrfbin/cheatsheet.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " Status Line
    Plug 'hoob3rt/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'

    " Git
    Plug 'tpope/vim-fugitive'
    " Plug 'itchyny/vim-gitbranch'
    Plug 'sindrets/diffview.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    "
    " Debug
    Plug 'puremourning/vimspector'
    Plug 'szw/vim-maximizer'
    "
    Plug 'windwp/nvim-autopairs'
    Plug 'lukas-reineke/virt-column.nvim'
    Plug 'sainnhe/edge'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'kassio/neoterm'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-unimpaired'
    Plug 'sbdchd/neoformat'
    Plug 'airblade/vim-gitgutter'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'mechatroner/rainbow_csv'
    Plug 'adamheins/vim-highlight-match-under-cursor'
    Plug 'tpope/vim-surround'
    Plug 'tjdevries/astronauta.nvim'
    Plug 'GustavoKatel/sidebar.nvim'
    if has("mac")
        Plug 'rizzatti/dash.vim'
    end

call plug#end()
" }}}

" Colors {{{
" Enables 24-bit RGB color in the TUI
if (has("termguicolors"))
    set termguicolors
    " set background = "light"
endif
if (has("gui_vimr"))
    set background = "light"
endif

" sainnhe/edge
let g:edge_style = 'aura'
:let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
colorscheme edge

" Make it obvious where 80 characters is
" set textwidth=80
" set colorcolumn=+1
set colorcolumn=80
highlight ColorColumn ctermbg=none guibg=none
" highlight ColorColumn guibg=#181818
"
" lukas-reineke/virt-column.nvim
lua<<EOF
-- vim.cmd [[ highlight VirtColumn guifg=grey80 guibg=none ]]

require("virt-column").setup { 
    char = "│",
}
EOF

" lukas-reineke/indent-blankline.nvim
lua <<EOF
require("indent_blankline").setup {
indent_blankline_char = "│",
}
EOF

" }}}

" Various {{{
" Edit config file
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>V :so $MYVIMRC<CR>

" toggle relativenumber
nnoremap <leader>tn :set invrelativenumber<cr>

" No highlight
nnoremap <leader>h :noh<CR>
nnoremap <CR> :noh<CR>

" Move in split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Change current directory to working file path
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Highlight syntax inside markdown
let g:markdown_fenced_languages = ['html', 'python', 'vim', 'r', 'sh']
" }}}

" szw/vim-maximizer {{{
nnoremap <leader>m :MaximizerToggle!<CR>
" }}}

" puremourning/vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dx :call vimspector#Reset()<CR>
nnoremap <leader>de :VimspectorEval
nnoremap <leader>dw :VimspectorWatch
nnoremap <leader>do :VimspectorShowOutput

nmap <leader>dj <Plug>VimSpctorStepInto
nmap <leader>dk <Plug>VimSpctorStepOut
nmap <leader>dl <Plug>VimSpctorStepOver
" }}}

" tpope/vim-commentary {{{
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>
" }}}

" Mac specific {{{
if has("mac")
    " Open Marked app
    nnoremap <leader>k :silent !open -a Marked\ 2.app '%:p'<cr>

    " rizzatti/dash.vim
    nmap <silent> <leader>d <Plug>DashSearch
end
" }}}

" kassio/neoterm {{{
" let g:neoterm_default_mod = 'vertical'
" let g:neoterm_size = 60
let g:neoterm_default_mod = 'belowright'
let g:neoterm_size = 18
let g:neoterm_autoinsert = 1
nnoremap <c-q> :Ttoggle<CR>
inoremap <c-q> <Esc>:Ttoggle<CR>
tnoremap <c-q> <c-\><c-n>:Ttoggle<CR>
" }}}

" sbdchd/neoformat {{{
nnoremap <leader>F :Neoformat prettier<CR>
" }}}

" Plug 'GustavoKatel/sidebar.nvim' {{{
lua << EOF
require("sidebar-nvim").setup({})
EOF
nnoremap <leader>sb <cmd>SidebarNvimToggle<CR>
" }}}

" hoob3rt/lualine.nvim {{{
lua << EOF
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_diagnostic'} }
                  },
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree'}
}
EOF
" }}}

" neovim/nvim-lspconfig {{{
lua<<EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {"pyright", "html", "r_language_server", "fortls", "yamlls", "bashls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- FIXME ccls
local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
    -- compilationDatabaseDirectory = "build";
    index = {
        threads = 0;
    };
    clang = {
        excludeArgs = {"-frounding-math"} ;
    };
}

EOF
" }}}

" kabouzeid/nvim-lspinstall {{{
" lua << EOF
" require'lspinstall'.setup() -- important
" local servers = require'lspinstall'.installed_servers()
" for _, server in pairs(servers) do
"   require'lspconfig'[server].setup{
"     capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"   }
" end
" EOF
" " }}}
    
" hrsh7th/nvim-cmp {{{
lua <<EOF

local lspkind = require('lspkind')
lspkind.init()

local cmp = require('cmp')
cmp.setup({

    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },

    mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
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
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    },

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "cmdline" },
      { name = "buffer" , keyword_length = 4}
    }),

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                cmdline = "[cmd]",
                },
            },
        },

    experimental = {
        native_menu = false,
        ghost_text = true
    }
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
      completion = {
          autocomplete = false,
          keyword_length = 3,
      },

    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline',
        max_item_count = 20,
        keyword_length = 3,
      }
    })
  })


-- Setup lspconfig.
--[[
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

	require('lspconfig')['r_language_server'].setup {
        capabilities = capabilities
	}
	require('lspconfig')['fortls'].setup {
        capabilities = capabilities
	}
	require('lspconfig')['pyright'].setup {
        capabilities = capabilities
	}
	require('lspconfig')['html'].setup {
        capabilities = capabilities
	}
	require('lspconfig')['yamlls'].setup {
        capabilities = capabilities
	}
]]--
EOF
" }}}

" kyazdani42/nvim-tree.lua {{{
lua require'nvim-tree'.setup()
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" }}}

" nvim-telescope/telescope {{{
lua <<EOF
local actions = require('telescope.actions')

-- require('telescope').load_extension('fzy')

require('telescope').setup {
    defaults = {
        prompt_prefix = '> ',
        -- prompt_prefix = "🔍 ",
        color_devicons = true,
        initial_mode = "insert",
        -- file_ignore_patterns = { "" },
        mappings = {
            i = {
                -- ["<c-x>"] = false,
                ["<C-h>"] = "which_key",
                -- ["<c-q>"] = actions.send_to_qflist,
                ["<esc>"] = actions.close,
            },
        }
    },
    pickers = {
        git_files = {
            shorten_path = true,
            layout_strategy = "horizontal",
            layout_options = {
                preview_width = 0.75,
            },
        },
        buffers = {
            show_all_buffers = true,
            show_last_used = true,
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    }
}
-- nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')
EOF

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').file_browser({hidden = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader><space> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ft <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Search for Simularia notes
nnoremap <leader>fn <cmd>lua require('telescope.builtin').live_grep( {cwd = "~/Simularia/Notes", prompt_title = "~ Simularia Notes ~", layout_strategy = "vertical" } )<cr>

" Telescope LSP commands
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references()<cr>
" }}}

" sindrets/diffview {{{
lua <<EOF
-- Lua
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true,         -- Requires nvim-web-devicons
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  file_panel = {
    position = "left",            -- One of 'left', 'right', 'top', 'bottom'
    width = 35,                   -- Only applies when position is 'left' or 'right'
    height = 10,                  -- Only applies when position is 'top' or 'bottom'
    listing_style = "tree",       -- One of 'list' or 'tree'
    tree_options = {              -- Only applies when listing_style is 'tree'
      flatten_dirs = true,
      folder_statuses = "always"  -- One of 'never', 'only_folded' or 'always'.
    }
  },
  file_history_panel = {
    position = "bottom",
    width = 35,
    height = 16,
    log_options = {
      max_count = 256,      -- Limit the number of commits
      follow = false,       -- Follow renames (only for single file)
      all = false,          -- Include all refs under 'refs/' including HEAD
      merges = false,       -- List only merge commits
      no_merges = false,    -- List no merge commits
      reverse = false,      -- List commits in reverse order
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
      ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]            = cb("options"),            -- Open the option panel
      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["j"]             = cb("next_entry"),
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}

EOF
" }}}

" lewis6991/gitsigns.nvim {{{
lua << EOF
    require('gitsigns').setup({})
EOF
" }}} 

" windwp/nvim-autopairs {{{
lua << EOF
    require('nvim-autopairs').setup()
EOF
" }}}

" Autocmd {{{

" Highlight on yank
autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" listchars
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
autocmd InsertEnter * set list
autocmd VimEnter,BufEnter,InsertLeave * set nolist
autocmd BufNewFile,BufRead *.md,*.mdx,*.markdown :set filetype=markdown

" Fold method for init.vim
" https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vi         mrc-file
autocmd FileType vim setlocal foldmethod=marker foldlevel=0 foldcolumn=3
" }}}

" Fortran specific {{{
" Fix issues with Fortran77
" let g:fortran_fixed_source = 1
" autocmd FileType fortran setlocal commentstring=C\ %s
" let b:commentary_startofline = 1
"
" Sfortunatamente abbiamo dei file .f90 che sono in Fortran77
" autocmd BufNewFile,BufRead *.f :set filetype=Fortran77,Fortran
" autocmd FileType Fortran77 setlocal commentstring=C\ %s
" autocmd Filetype Fortran77 let g:fortran_fixed_source=1
" autocmd Filetype Fortran77 let b:commentary_startofline=1
" }}}

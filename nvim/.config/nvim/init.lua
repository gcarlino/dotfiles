-- General setup {{{
local opts = { noremap = true, silent = true }

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 4
vim.o.diffopt = 'internal,filler,closeoff,vertical'
-- }}}

-- Plugins {{{

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup( function()

    -- LSP
    -- Installati a mano i server di:
    --   R:       install.packages("languageserver")
    --   Python:  npm install -g pyright
    --   Fortran: pip install -U fortran-language-server
    --   HTML:    npm install -g vscode-langservers-extracted
    --   YAML:    brew install yaml-language-server
    --   BASH:    brew install bash-language-server
	--   LUA:     brew install lua-language-server
    --   LATEX:   brew install texlab
    --   cmake:   pip3 install cmake-language-server
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'

    -- Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'kdheepak/cmp-latex-symbols'

    -- Snippet
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'kyazdani42/nvim-tree.lua'
    use 'sudormrfbin/cheatsheet.nvim'

    use 'nvim-treesitter/nvim-treesitter'

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Git
    use 'tpope/vim-fugitive'
    -- use 'itchyny/vim-gitbranch'
    use 'lewis6991/gitsigns.nvim'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'airblade/vim-gitgutter'

    -- R
    use 'jalvesaq/Nvim-R'

    -- Debug
    use 'puremourning/vimspector'
    use 'szw/vim-maximizer'

    -- Color schemes
    use 'sainnhe/edge'

    -- Various
    use 'chentau/marks.nvim'
    use 'lukas-reineke/virt-column.nvim'
    -- use 'christoomey/vim-tmux-navigator'
    use 'kassio/neoterm'
    use 'tpope/vim-commentary'
    -- use 'tpope/vim-unimpaired'
    -- use 'sbdchd/neoformat'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mechatroner/rainbow_csv'
    use 'adamheins/vim-highlight-match-under-cursor'
    use 'tpope/vim-surround'
    -- use 'tjdevries/astronauta.nvim'
    use 'GustavoKatel/sidebar.nvim'

    -- Mac specific
    if vim.fn.has('mac') == 1 then
        use 'rizzatti/dash.vim'
    end

end )
-- }}}

-- Colors {{{
vim.cmd [[ set termguicolors ]]
-- vim.g.background = 'light'

-- sainnhe/edge
vim.g.edge_style = 'aura'
vim.g.edge_enable = 1
vim.g.edge_enable_italic = 1
vim.g.edge_disable_italic_comment = 1
vim.cmd [[ colorscheme edge ]]
-- }}}

-- Various {{{
-- Edit config file
vim.api.nvim_set_keymap('n', '<leader>v', ':e $MYVIMRC<CR>', {noremap = true})

-- No highlight
vim.api.nvim_set_keymap('n', '<CR>', ':noh<CR>', {noremap = true, silent = true})

-- Move in split navigations
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', {noremap = true})

-- Move lines around
vim.api.nvim_set_keymap('n', '<M-j>', ':m .+1<CR>==', {noremap = true})
vim.api.nvim_set_keymap('n', '<M-k>', ':m .-2<CR>==', {noremap = true})
vim.api.nvim_set_keymap('i', '<M-j>', '<ESC>:m .+1<CR>==gi', {noremap = true})
vim.api.nvim_set_keymap('i', '<M-k>', '<ESC>:m .-2<CR>==gi', {noremap = true})
vim.api.nvim_set_keymap('v', '<M-j>', ":m '>+1<CR>gv==gv", {noremap = true})
vim.api.nvim_set_keymap('v', '<M-k>', ":m '<-2<CR>gv==gv", {noremap = true})

-- Change current directory to working file path
vim.api.nvim_set_keymap('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', {noremap = true })

-- Highlight syntax inside markdown
vim.g.markdown_fenced_languages = { 'html', 'python', 'vim', 'r', 'sh' }

-- Highlight on yank
vim.cmd [[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
]]
-- }}}

-- listchars {{{
vim.cmd [[
    set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
    autocmd InsertEnter * set list
    autocmd VimEnter,BufEnter,InsertLeave * set nolist
    autocmd BufNewFile,BufRead *.md,*.mdx,*.markdown :set filetype=markdown
]]
-- }}}

-- Mac specific {{{
if vim.fn.has('mac') == 1 then
    vim.api.nvim_set_keymap('n', '<leader>k', ':silent !open -a "Marked 2.app" %<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>d', '<Plug>DashSearch', {silent = true})
end
-- }}}

-- hoob3rt/lualine.nvim {{{
require'lualine'.setup {
    -- Default config (see help)
    options = {
        theme = 'edge'
    },
    extensions = {'nvim-tree'}
}
-- }}}

-- lukas-reineke/virt-column.nvim {{{
require("virt-column").setup { }
-- vim.wo.colorcolumn = '80'
-- vim.cmd [[
-- highlight VirtuColumn guifg=#00FF00
-- ]]
-- }}}

-- lukas-reineke/indent-blankline.nvim {{{
require("indent_blankline").setup {
    indent_blankline_char = "│",
    indent_blankline_filetype_exclude = { 'help', 'packer' },
    indent_blankline_buftype_exclude = { 'terminal', 'nofile' },
    indent_blankline_show_trailing_blankline_indent = false
}
-- }}}

-- lewis6991/gitsigns.nvim {{{
require('gitsigns').setup {
	signs = {
		add = {hl = 'GitGutterAdd', text = '+'},
		change = {hl = 'GitGutterChange', text = '~'},
		delete = {hl = 'GitGuttereDelete', text = '_' },
		topdelete = { hl = 'GitGutterDelete', text = '‾' },
		changedelete = { hl = 'GitGutterChange', text = '~' },
	},
}
-- }}}

-- szw/vim-maximizer {{{
vim.api.nvim_set_keymap('n', '<leader>m', ':MaximizerToggle!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-W><C-m>', ':MaximizerToggle!<CR>', {noremap = true})
-- }}}

-- puremourning/vimspector {{{
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.api.nvim_set_keymap('n', '<leader>dd', ':call vimspector#Launch()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dx', ':call vimspector#Reset()<CR>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>de', ':VimspectorEval',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dw', ':VimspectorWatch', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>do', ':VimspectorShowOutput', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>dj', ':VimSpectorStepInto',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dk', ':VimSpectorStepOut', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dl', ':VimSpectorStepOver', {noremap = true, silent = true})

-- mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)
-- for normal mode - the word under the cursor
-- for visual mode, the visually selected text
vim.cmd([[
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
]])

-- }}}

-- tpope/vim-commentary {{{
vim.api.nvim_set_keymap('n', '<leader>/', ':Commentary<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>/', ':Commentary<CR>', {noremap = true})
-- }}}

-- kassio/neoterm {{{
vim.g.neoterm_default_mod = 'belowright'
vim.g.neoterm_size = 18
vim.g.neoterm_autoinsert = 1
vim.api.nvim_set_keymap('n', '<c-q>', ":<c-u>exec v:count.'Ttoggle'<CR>", {noremap = true})
vim.api.nvim_set_keymap('i', '<c-q>', '<Esc>:Ttoggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('t', '<c-q>', '<c-\\><c-n>:Ttoggle<CR>', {noremap = true})
-- }}}

-- sbdchd/neoformat {{{
vim.api.nvim_set_keymap('n', '<leader>F', ':Neoformat prettier<CR>', {noremap = true})
-- }}}

-- GustavoKatel/sidebar.nvim {{{
require("sidebar-nvim").setup({})
-- nnoremap <leader>sb <cmd>SidebarNvimToggle<CR>
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>SidebarNvimToggle<CR>', {noremap = true})
-- }}}

-- nvim-telescope/telescope {{{

local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        color_devicons = true,
        -- initial_mode = "insert",
        mappings = {
            i = {
                -- ["<c-x>"] = false,
                ["<C-h>"] = "which_key",
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
	    },
    },
}

-- nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').file_browser({hidden = true })<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sw', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

-- Telescope for git
vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>gh', [[<cmd>lua require('telescope.builtin').git_stash()<CR>]], opts)


-- Search for Simularia notes
if vim.fn.has("mac") == 1 then
    vim.api.nvim_set_keymap('n', '<leader>sn', [[<cmd>lua require('my_telescope').search_mynotes()<CR>]], opts)
end

-- Search nvim dotfiles
vim.api.nvim_set_keymap('n', '<leader>en', [[<cmd>lua require('my_telescope').edit_nvim()<CR>]], opts)

-- Search dotfiles
vim.api.nvim_set_keymap('n', '<leader>ed', [[<cmd>lua require('my_telescope').edit_dotfiles()<CR>]], opts)


-- Telescope LSP commands
--
-- nnoremap <leader>ls <cmd>lua require('telescope.builtin').lsp_references()<cr>
vim.api.nvim_set_keymap('n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], {noremap = true})
-- }}}

-- Treesitter configuration {{{
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
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
}
-- }}}

-- neovi/nvim-lspconfig {{{
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = {'pyright', 'html', 'r_language_server', 'yamlls', 'bashls', 'texlab', 'cmake' }
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
    filetypes = { "fortran" },
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
      { name = "buffer" , keyword_length = 4}
    }),

    formatting = {
        format = lspkind.cmp_format {
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
            },
        },

    experimental = {
        native_menu = false,
        ghost_text = true
    }
  })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline',
            keyword_length = 3}
    })
})

-- Load snippets
require('luasnip.loaders.from_vscode').lazy_load()
-- }}}


-- kyazdani42/nvim-tree.lua {{{
local nvim_tree = require 'nvim-tree'
nvim_tree.setup()
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', {noremap = true})
-- }}}

-- sindrets/diffview {{{

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
-- }}}

-- chentau/marks.nvim {{{
require'marks'.setup {
    default_mappings = true,
}
-- }}}

-- Fold method for init.lua {{{
vim.cmd [[
autocmd FileType lua setlocal foldmethod=marker foldlevel=0 foldcolumn=3
]]
-- }}}

-- Fortran specific {{{
vim.cmd [[
    augroup Fortran77
        autocmd!
        autocmd BufNewFile,BufRead *.f :set filetype=Fortran77
        autocmd BufNewFile,BufRead *.f :set syntax=Fortran
        autocmd FileType Fortran77 setlocal commentstring=C\ %s
        autocmd Filetype Fortran77 let g:fortran_fixed_source=1
        autocmd Filetype Fortran77 let b:commentary_startofline=1
        autocmd Filetype Fortran77 set tabstop=6 
        autocmd Filetype Fortran77 set shiftwidth=6
    augroup end
    doautoall Fortran77 FileType Loaded-Buffer
]]
-- }}}

-- jalvesazq/Nvim-R {{{
-- " autocmd VimLfave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
-- " R output is highlighted using current :colorscheme
-- Enable syntax folding
vim.cmd [[
let rout_follow_colorscheme = 1
let r_syntax_folding = 1
set nofoldenable
]]
-- }}}

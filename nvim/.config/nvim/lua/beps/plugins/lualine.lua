-- local colors = require('onedark.palette')['dark']
local colors = require('nightfox.palette').load('nordfox')


local filename_symbols = { modified = ' ●', alternate_file = ' #', directory = ' ' }


local function getCWD()
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
    return vim.fn.pathshorten(cwd)
end


--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end


-- External diff source
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end


local function getLSP()
    local msg = 'No Active LSP'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end
    return msg
end


require 'lualine'.setup {
    extensions = {
        'nvim-tree', 'toggleterm', 'nvim-dap-ui', 'fugitive',
        'fzf', 'quickfix'
    },
    options = {
        theme = 'auto',
        globalstatusline = false,
       -- section_separatoRs = { left = '', right = '' },
        -- component_separators = { left = '', right = '' }
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        section_separators = "",
        component_separators = "",

        disabled_filetypes = {
            winbar = { 'toggleterm', 'NvimTree', 'fugitive', 'qf',
                'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes',
                'dapui_repl', 'dapui_console', 'dap-repl',
                'DiffviewFiles', 'DiffviewFileHistory',
            }
        },
    },
    sections = {
        lualine_a = {
            {
                'mode',
                icons_enabled = true,
                icon = '',
                fmt = trunc(100, 1, 0, true),
            }
        },
        -- lualine_b = {
        --     {
        --         getCWD,
        --         icon = ' ',
        --         color = {
        --             fg = colors.blue.bright,
        --             gui = 'italic',
        --         },
        --     },
        -- },
        lualine_b = {
            {
                'branch',
                -- color = { fg = colors.pink.dim, }
                fmt = trunc(100, 4, 80, true),

            },
            {
                'diff',
                source = diff_source,
                -- symbols = { added = ' ', modified = '柳', removed = ' ' },
                symbols = { added = ' ', modified = ' ', removed = ' ' },
            },
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                -- symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                symbols = { error = " ", warn = " ", hint = " ", info = " " },
            },
        },
        lualine_c = {
            {
                'filetype',
                icon_only = true,
                colored = false,
                padding = { left = 1, right = 0 },
                -- color = {
                --     fg = colors.pink.dim,
                -- },
            },
            {
                'filename',
                file_status = true,
                path = 1,
                shorting_target = 30,
                color = { gui = 'italic' },
                symbols = filename_symbols,
            }
        },
        lualine_x = {
            {
                getLSP,
                icon = ' ',
                color = {
                    fg = colors.pink.dim,
                    -- gui = 'bold',
                },
                fmt = trunc(100, 4, 90, true)
            },
        },
        lualine_y = {
            {
                'fileformat',
                padding = { left = 1, right = 0 },
            },
            {
                'encoding',
                padding = {left = 1, right = 1 }
            },
            {
                'filesize',
                padding = {left = 0, right = 1 }
            }
        },
        lualine_z = {
            {
                'location',
                padding = {left = 1, right = 0}
            },
            {
                'progress',
                padding = {left = 1, right = 1}
            }
        }
    },
}

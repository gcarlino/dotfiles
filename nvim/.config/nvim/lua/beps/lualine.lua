-- local colors = {
--     -- -- edge
--     -- bg       = '#2b2d37',
--     -- bg1      = '#333644',
--     -- bg2      = '#363a49',
--     -- bg3      = '#3a3e4e',
--     -- bg4      = '#404455',
--     -- fg       = '#97a4b5',
--     -- yellow   = '#deb974',
--     -- cyan     = '#5dbbc1',
--     -- darkblue = '#081633',
--     -- green    = '#a0c980',
--     -- orange   = '#FF8800',
--     -- violet   = '#a9a1e1',
--     -- magenta  = '#c678dd',
--     -- blue     = '#6cb6eb',
--     -- red      = '#ec7279',
-- }

-- local colors = require('onedark.palette')['dark']
local colors = require('nightfox.palette').load('nordfox')

local function getCWD()
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
    return vim.fn.pathshorten(cwd)
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
    extensions = { 'nvim-tree', 'toggleterm', 'nvim-dap-ui', 'fugitive', 'symbols-outline' },
    options = {
        theme = 'auto',
        globalstatusline = true,
        -- section_separatoRs = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = "",
        disabled_filetypes = {
            winbar = { "toggleterm" },
        },
    },
    sections = {
        lualine_a = {
            {
                'mode',
                icons_enabled = true,
                icon = '',
            }
        },
        lualine_b = {
            {
                getCWD,
                icon = ' ',
                color = {
                    fg = colors.blue.bright,
                    gui = 'italic',
                },
            },
        },
        lualine_c = {
            {
                'branch',
                color = {
                    fg = colors.pink.dim,
                }
            },
            {
                'diff',
                -- symbols = { added = ' ', modified = '柳', removed = ' ' },
                symbols = { added = ' ', modified = ' ', removed = ' ' },
                -- diff_color = {
                --     added = { fg = colors.green },
                --     modified = { fg = colors.cyan },
                --     removed = { fg = colors.red },
                -- },
            },
        },

        lualine_x = {
            {
                getLSP,
                icon = ' ',
                color = {
                    fg = colors.pink.dim,
                    -- gui = 'bold',
                },
            },
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                -- symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                symbols = { error = " ", warn = " ", hint = " ", info = " " },
                -- diagnostics_color = {
                --     error = { fg = colors.red },
                --     warn = { fg = colors.yellow },
                --     info = { fg = colors.cyan },
                --     hint = { fg = colors.green },
                -- },
            },
        },
        lualine_y = { 'filesize', 'encoding', 'fileformat' },
        lualine_z = { 'progress', 'location' }
    },
    winbar = {
        lualine_a = {
            {
                'filetype',
                icon_only = true,
                colored = false,
                color = {
                    -- fg = colors.blue,
                    -- bg = colors.bg4
                }
            },
            {
                'filename',
                file_status = true,
                path = 1,
                color = {
                    -- fg = colors.blue,
                    -- bg = colors.bg4,
                    gui = 'italic',
                },
                symbols = {
                    modified = ' ●',
                    alternate_file = ' #',
                    directory = ' ',
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {
            {
                'filetype',
                icon_only = true,
                colored = false,
                color = {
                    -- bg = colors.bg2,
                }
            },
            {
                'filename',
                path = 1,
                color = {
                    gui = 'italic',
                },
                symbols = {
                    modified = ' ●',
                    alternate_file = ' #',
                    directory = ' ',
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}

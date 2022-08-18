local colors = {
    bg       = '#2b2d37',
    fg       = '#97a4b5',
    yellow   = '#deb974',
    cyan     = '#5dbbc1',
    darkblue = '#081633',
    green    = '#a0c980',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#6cb6eb',
    red      = '#ec7279',
}

local function getCWD()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

local function getLSP()
    local msg = 'No Active Lsp'
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
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = "",
    },
    sections = {
        lualine_b = {
            {
               getCWD,
                icon = ' ',
                color = {
                    fg = colors.blue,
                },
            },
            {
                'branch',
                color = {
                    fg = colors.fg,
                }
            },
            {
                'diff',
                symbols = { added = ' ', modified = '柳', removed = ' ' },
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.orange },
                    removed = { fg = colors.red },
                },
            },
        },
        lualine_c = {
            '%=',
            {
                'filetype',
                icon_only = true
            },
            {
                'filename',
                file_status = true,
                path = 1,
                color = {
                    fg = colors.blue,
                },
                symbols = {
                    modified = ' ●',      -- Text to show when the buffer is modified
                    alternate_file = '#', -- Text to show to identify the alternate file
                    directory =  '',     -- Text to show when the buffer is a directory
                },
            },
        },

        lualine_x = {
            {
                getLSP,
                icon = ' ',
                color = {
                    fg = colors.fg,
                    -- gui = 'bold' },
                    },
            },
            {
                'diagnostics',
                sources = { 'nvim_diagnostic', 'nvim_lsp' },
                symbols = { error = ' ', warn = ' ', info = ' ' },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warn = { fg = colors.yellow },
                    info = { fg = colors.cyan },
                },
            },
        },
        lualine_y = { 'filesize', 'encoding', 'fileformat' },
        lualine_z = { 'progress', 'location' }
    },
    -- winbar = {
    --     lualine_a = { 'filename', },
    --     lualine_b = {},
    --     lualine_c = {},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = {}
    -- },
    -- inactive_winbar = {
    --     lualine_a = { 'filename', },
    --     lualine_b = {},
    --     lualine_c = {},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = {}
    -- }
}

-- Get position as <current line>|<total lines>|<cursor column>|<total columns>
local function myLocation()
    local linelength = vim.api.nvim_strwidth(vim.api.nvim_get_current_line())
    local sLinelength = string.format('%-2d', linelength)
    -- return '%l|%L│%3v|' .. linelength
    return '‖%2v|' .. sLinelength .. '⎢ %l|%-3L'
end

--- Return function that can format the component accordingly
--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
        end
        return str
    end
end


local function getLSP()
    local msg = 'No Active LSP'
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()
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
        'nvim-tree',
        'toggleterm',
        'nvim-dap-ui',
        'fugitive',
        'fzf',
        'quickfix',
        'man'
    },
    options = {
        theme = 'auto',
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
            statusbar = {},
            winbar = {},
        },
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            {
                'mode',
                icons_enabled = true,
                icon = '',
                fmt = function(str) return str:sub(1,1) end,
            }
        },
        lualine_b = {
            {
                'branch',
                fmt = trunc(90, 4, 60, true),
            },
            {
                'diff',
                colored = true,
                padding = { left = 0, right = 1 },
                fmt = trunc(0, 0, 90, true),
            },
            {
                'diagnostics',
                icon = { '' },
                sources = { 'nvim_diagnostic' },
                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                padding = { right = 1 },
                fmt = trunc(0, 0, 90, true),
                on_click = function ()
                    vim.diagnostic.setqflist()
                end,
            },
        },
        lualine_c = {
            {
                'filename',
                file_status = true,
                newfile_status = true,
                path = 3,   -- Absolute path with tilde as the home directory
                shorting_target = 80,
                symbols =  {
                    modified = '●',
                    alternate_file = '#',
                    directory = ' ',
                    newfile = ' '
                },
                on_click = function ()
                    local fpath = vim.fn.expand('%:~')
                    print(fpath)
                end
            }
        },
        lualine_x = {},
        lualine_y = {
            {
                'filetype',
                icon_only = true,
                padding = { left = 1, right = 0 },
                colored = false,
            },
            {
                getLSP,
                padding = { left = 0, right = 0 },
                fmt = trunc(92, 0, 92, true),
                colored = false,
            },
            {
                'fileformat',
                padding = { left = 1, right = 1 },
                colored = false,
            },
            {
                'encoding',
                padding = {left = 0, right = 0 },
                fmt = trunc(92, 0, 92, true),
                colored = false,
            },
            {
                'filesize',
                colored = false,
            },
        },
        lualine_z = { myLocation },
    },
    inactive_sections = {
        lualine_a = {
            {
                'mode',
                icons_enabled = true,
                icon = '',
                fmt = function() return " " end,
            },
        },
        lualine_b = {},
        lualine_c = { { 'filename', path = 3, shorting_target = 10 } },
        lualine_x = { myLocation },
        lualine_y = {},
        lualine_z = {}
    },
}

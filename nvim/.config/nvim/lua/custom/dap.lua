local M = {}

local dap = require("dap")

-- Function to configure adapters
function M.config_dap()

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/codelldb',
            args = {"--port", "${port}"}
        }

    }
    dap.adapters.cpp = dap.adapters.codelldb
    dap.adapters.c = dap.adapters.codelldb

    -- Load local configurations
    require('dap.ext.vscode').load_launchjs('./.nvim-dap/launch.json')

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            args = {
                -- "/media/disc2/massimiliano/PROJ_SHPTODONCAR/SHPTODONCAR/esempio/grafo_connesso.shp",
                -- "-id",
                -- "id"
            },
            stopOnEntry = false,
        },
    }

    -- Python debug

    -- It assumes that you're using the same python version as in the virtualenv.
    -- The main idea behind this is that it avoids having to install debugpy in
    -- every virtualenv you create.
    -- See https://github.com/mfussenegger/nvim-dap-python/issues/79
    require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

end

-- nvim-dap-ui
local dapui = require("dapui")
dapui.setup()

-- DAP virtual text
local nvim_dap_virtual_text = require('nvim-dap-virtual-text')
nvim_dap_virtual_text.setup({ virt_text_pos = 'eol', })

-- Breakpoint symbols
vim.fn.sign_define('DapBreakpoint', { icon = '●', text = '●', texthl = "DiagnosticSignError", linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { icon = '●', text = '●', texthl = "DiagnosticSignWarning", linehl = '', numhl = '' })


-- Clear configurations
function M.clear_configurations()
    dap.configurations.codelldb = {}
    dap.configurations.cpp = {}
    dap.configurations.c = {}
    dap.configurations.fortran = {}
    dap.configurations.python = {}
end

-- telescope
local tstatus, telescope = pcall(require, 'telescope')
if tstatus then
    telescope.load_extension('dap')
end

------------------
-- key mappings --
------------------

local set = vim.keymap.set

-- Clear configurations, reload and continue
set("n", "<leader>dd",
    function()
        M.clear_configurations()
        M.config_dap()
        -- dap.continue()
        telescope.extensions.dap.configurations{}
    end,
    { desc = "DAP: debug load configurations with Telescope" }
)

set('n', '<leader>db', dap.toggle_breakpoint, { desc = "DAP: debug toggle [b]reakpoint" })

set('n', '<F1>', dap.continue, { desc = "DAP: debug continue" })
set('n', '<F2>', dap.step_over, { desc = "DAP: debug step over" })
set('n', '<F3>', dap.step_into, { desc = "DAP: debug step into" })
set('n', '<F4>', dap.step_out, { desc = "DAP: debug step out" })

set('n', '<F5>', dap.run_last, { desc = "DAP: debug run last configuration" })
set('n', '<F6>', dap.run_to_cursor, { desc = "DAP: debug run to cursor" })
set('n', '<F11>', dap.pause, { desc = "DAP: debug pause" })
set('n', '<F12>', dap.terminate, { desc = "DAP: debug terminate" })

set("n", "<F8>", dap.up, { desc = "DAP: up in the stack." })
set("n", "<F9>", dap.down, { desc = "DAP: down in the stack." })

set('n', '<leader>dx',
    function()
        dap.disconnect()
        dap.close()
    end,
    { desc = "DAP: debug disconnect" })

set('n', '<leader>dt', dapui.toggle, { desc = "DAP: debug toggle dap-ui" })

set('n', '<leader>dc', dapui.close, { desc = "DAP: debug close dap-ui" })

-- hover
set({ 'n', 'x' }, '<leader>di', dapui.eval,
    { desc = "DAP: [i]nspect: eval the expression" })

set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = "DAP: expression in a floating window" })

set({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end, { desc = "DAP: expression in the preview window" })

set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, { desc = "DAP: print the stack frames" })

set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
    end, { desc = "DAP: print variables in the current scopes" })

-- Reload launch json configuration
set('n', '<leader>dl', function() require("dap.ext.vscode").load_launchjs("./.nvim-dap/launch.json") end,
    { desc = "DAP: load ./.nvim-dap/launch.json with debugger configuration" })

-- Use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end


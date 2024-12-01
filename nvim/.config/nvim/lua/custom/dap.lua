local dap = require("dap")

-- nvim-dap-ui
local dapui = require("dapui")
dapui.setup()

-- DAP virtual text
require('nvim-dap-virtual-text').setup({
    virt_text_pos = 'eol',
})

-- telescope
local tstatus, telescope = pcall(require, 'telescope')
if tstatus then
    telescope.load_extension('dap')
end

-- Breakpoint symbols
vim.fn.sign_define('DapBreakpoint',
    { icon = '●', text = '●', texthl = "DiagnosticSignError", linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition',
    { icon = '●', text = '●', texthl = "DiagnosticSignWarning", linehl = '', numhl = '' })

-- Define functions to be called later by keymaps
local M = {}

-- Function to configure adapters
function M.config_dap()

    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
    }

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/codelldb',
            args = {"--port", "${port}"}
        }
    }

    dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7'
    }

    -- Load local configurations
    require('dap.ext.vscode').load_launchjs('.nvim-dap/launch.json')

    -- EXAMPLE configuration
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

-- Clear configurations
function M.clear_configurations()
    dap.configurations.codelldb = {}
    dap.configurations.cpp = {}
    dap.configurations.c = {}
    dap.configurations.fortran = {}
    dap.configurations.python = {}
end

------------------
-- key mappings --
------------------

-- Clear configurations, reload and continue
vim.keymap.set("n", "<leader>dd",
    function()
        M.clear_configurations()
        M.config_dap()
        -- dap.continue()
        telescope.extensions.dap.configurations{}
    end,
    { desc = "DAP: debug load configurations with Telescope" }
)

-- Breakpoint
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "DAP: debug toggle [b]reakpoint" })
vim.keymap.set('n', '<leader>dg', dap.run_to_cursor, { desc = "DAP: debug run to cursor" })

-- Run debug
vim.keymap.set('n', '<F1>', dap.continue, { desc = "DAP: debug continue" })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = "DAP: debug step into" })
vim.keymap.set('n', '<F3>', dap.step_over, { desc = "DAP: debug step over" })
vim.keymap.set('n', '<F4>', dap.step_out, { desc = "DAP: debug step out" })
vim.keymap.set('n', '<F5>', dap.step_back)


vim.keymap.set('n', '<F9>', dap.run_last, { desc = "DAP: debug run last configuration" })
vim.keymap.set('n', '<F10>', dap.restart, { desc = "DAP: debug restart" })
vim.keymap.set('n', '<F11>', dap.pause, { desc = "DAP: debug pause" })
vim.keymap.set('n', '<F12>', dap.terminate, { desc = "DAP: debug terminate" })

-- Disconnect
vim.keymap.set('n', '<leader>dx',
    function()
        dap.disconnect()
        dap.close()
    end,
    { desc = "DAP: debug disconnect" })

-- Toggle ui and close ui
vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = "DAP: debug toggle dap-ui" })
vim.keymap.set('n', '<leader>dc', dapui.close, { desc = "DAP: debug close dap-ui" })

-- hover
vim.keymap.set({ 'n', 'x' }, '<leader>di', dapui.eval,
    { desc = "DAP: [i]nspect: eval the expression" })

vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end,
    { desc = "DAP: expression in a floating window" })

vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end,
    { desc = "DAP: expression in the preview window" })

vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, { desc = "DAP: print the stack frames" })

vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end, { desc = "DAP: print variables in the current scopes" })

-- Reload launch json configuration
vim.keymap.set('n', '<leader>dl', function() require("dap.ext.vscode").load_launchjs(".nvim-dap/launch.json") end,
    { desc = "DAP: load ./.nvim-dap/launch.json with debugger configuration" })

-- Use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

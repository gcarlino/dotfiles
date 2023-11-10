local M = {}

local dap = require("dap")
local dapui = require("dapui")

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
    dap.adapters.fortran = dap.adapters.codelldb
    dap.adapters.fortran08 = dap.adapters.codelldb

    -- Load local configurations
    require('dap.ext.vscode').load_launchjs('./.nvim-dap/launch.json')

    -- dap.configurations.cpp = {
    --     {
    --         name = "Launch file",
    --         type = "codelldb",
    --         request = "launch",
    --         program = function()
    --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --         end,
    --         cwd = '${workspaceFolder}',
    --         args = {
    --             "/media/disc2/massimiliano/PROJ_SHPTODONCAR/SHPTODONCAR/esempio/grafo_connesso.shp",
    --             "-id",
    --             "id"
    --         },
    --         stopOnEntry = false,
    --     },
    -- }

    -- Python debug
    -- require('dap-python').setup('~/.virtualenvs/neovim3/bin/python')
    require('dap-python').setup("/opt/homebrew/bin/python3")

end

-- Clear configurations
function M.clear_configurations()
    dap.configurations.codelldb = {}
    dap.configurations.cpp = {}
    dap.configurations.c = {}
    dap.configurations.fortran = {}
    dap.configurations.python = {}
end

-- nvim-dap-ui
dapui.setup()

-- telescope
local tstatus, telescope = pcall(require, 'telescope')
if tstatus then
    telescope.load_extension('dap')
end

-- Breakpoint symbols
vim.fn.sign_define('DapBreakpoint', { icon = '●', text = '●', texthl = "DiagnosticSignError", linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { icon = '●', text = '●', texthl = "DiagnosticSignWarning", linehl = '', numhl = '' })

-- DAP virtual text
local nstatus, nvim_dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not nstatus then
   return
end
nvim_dap_virtual_text.setup({
    virt_text_win_col = 80,
})


------------------
-- key mappings --
------------------

-- Clear configurations, reload and continue
vim.keymap.set("n", "<leader>dd",
    function()
        M.clear_configurations()
        M.config_dap()
        dap.continue()
    end,
    { desc = "DAP: debug load configurations with Telescope" }
)

vim.keymap.set('n', '<F5>', function() dap.continue() end,
    { desc = "DAP: debug continue" })
vim.keymap.set('n', '<F4>', function() dap.run_last() end,
    { desc = "DAP: debug run last configuration" })
vim.keymap.set('n', '<F3>', function() dap.pause() end,
    { desc = "DAP: debug pause" })
vim.keymap.set('n', '<F2>', function() dap.terminate() end,
    { desc = "DAP: debug terminate" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end,
    { desc = "DAP: debug step over" })
vim.keymap.set('n', '<F11>', function() dap.step_into() end,
    { desc = "DAP: debug step into" })
vim.keymap.set('n', '<F12>', function() dap.step_out() end,
    { desc = "DAP: debug step out" })
vim.keymap.set('n', '<F8>', function() dap.run_to_cursor() end,
    { desc = "DAP: debug run to cursor" })
vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end,
    { desc = "DAP: debug toggle breakpoint" })

vim.keymap.set("n", "<F6>", function() dap.up() end, { desc = "DAP: up in the stack." })
vim.keymap.set("n", "<F7>", function() dap.down() end, { desc = "DAP: downupup in the stack." })

vim.keymap.set('n', '<leader>db', function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "DAP: debug set breakpoint condition" })
vim.keymap.set('n', '<leader>dx',
    function()
        dap.disconnect()
        dap.close()
    end,
    { desc = "DAP: debug disconnect" })
vim.keymap.set('n', '<leader>dt', function() dapui.toggle({}) end,
    { desc = "DAP: debug toggle dap-ui" })
vim.keymap.set('n', '<leader>dc', function() dapui.close({}) end,
    { desc = "DAP: debug close dap-ui" })

-- hover
vim.keymap.set({ 'n', 'x' }, '<leader>i', function() dapui.eval() end,
    { desc = "DAP: open a floating window containing the result of evaluting an expression" })

-- Reload launch json configuration
vim.keymap.set('n', '<leader>dl', function() require("dap.ext.vscode").load_launchjs("./.nvim-dap/launch.json") end,
    { desc = "DAP: load ./.nvim-dap/launch.json with debugger configuration" })

-- Use nvim-dap events to open and close the windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end


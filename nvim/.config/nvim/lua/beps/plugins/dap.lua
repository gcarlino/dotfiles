local status, dap = pcall(require, 'dap')
if not status then
    return
end

local dstatus, dapui = pcall(require, 'dapui')
if not dstatus then
    return
end

local M = {}

-- Function to configure adapters
function M.config_dap()

    -- C/C++/Rust (via vscode-cpptools)
    local cppdbgPath = ""
    if vim.fn.has("mac") == 1 then
        cppdbgPath = '/Users/beps/.vscode-server/extension/debugAdapters/bin/OpenDebugAD7'
    else
        cppdbgPath = '/home/carlino/.vscode-server/extension/debugAdapters/bin/OpenDebugAD7'
    end

    dap.adapters.fortran = {
        id = 'cppdbg',
        type = 'executable',
        command = cppdbgPath,
        -- options = {}  TODO: kill telemetry
    }

    -- Load local configurations
    require('dap.ext.vscode').load_launchjs('./.nvim-dap/launch.json')

    -- Python debug
    -- require('dap-python').setup('~/.virtualenvs/neovim3/bin/python')
    require('dap-python').setup("/opt/homebrew/bin/python3")

end

-- Clear configurations
function M.clear_configurations()
    dap.configurations.python = {}
    dap.configurations.fortran = {}
end

-- nvim-dap-ui
dapui.setup()

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


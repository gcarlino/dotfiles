-- Configuration file for DAP

local dap = require("dap")

local M = {}

-- Function to configure adapters
function M.config_dap()
    -- C/C++/Rust (via vscode-cpptools)
    dap.adapters.fortran = {
        id = 'cppdbg',
        type = 'executable',
        command = '/home/carlino/.vscode-server/extensions/ms-vscode.cpptools-1.10.7/debugAdapters/bin/OpenDebugAD7'
    }

    -- Python debug
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

    -- Load local configurations
    require('dap.ext.vscode').load_launchjs('./.nvim-dap/launch.json')
end

-- Clear configurations
function M.clear_configurations()
    dap.configurations.python = {}
    dap.configurations.fortran = {}
end

return M

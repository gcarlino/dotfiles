require("beps.options")
require("beps.disable_builtin")
require("beps.keymaps")

if vim.fn.has("mac") == 1 then
    require("beps.mac")
end

-- lewis6991/impatient.nvim 
require('impatient')

require("plugins")
require('beps.plugins.treesitter')
require('beps.plugins.telescope')
require('beps.plugins.dap')
require('beps.plugins.nvim-cmp')
require('beps.plugins.gitsigns')
require('beps.plugins.diffview')
require("beps.plugins.lualine")
require('beps.plugins.nvim-ufo')

require('beps.lsp')
require('beps.colorscheme')

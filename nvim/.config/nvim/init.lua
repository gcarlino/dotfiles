require("beps.options")

-- Mac spefic configuration
if vim.fn.has("mac") == 1 then
    require("beps.mac")
end

require("beps.keymaps")
require("beps.disable_builtin")

-- lewis6991/impatient.nvim 
require('impatient')

require("plugins")

require('beps.colorscheme')
require('beps.plugins.treesitter')
require('beps.plugins.telescope')
require('beps.plugins.dap')
require('beps.lsp')
require('beps.plugins.nvim-cmp')
require('beps.plugins.gitsigns')
require('beps.plugins.diffview')
require("beps.plugins.lualine")
require('beps.plugins.nvim-ufo')


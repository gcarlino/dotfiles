require("beps.options")
if vim.fn.has("mac") == 1 then
    require("beps.mac")
end
require("beps.disable_builtin")
require("beps.keymaps")

-- lewis6991/impatient.nvim 
require('impatient')

require("beps.packer")
require('beps.lsp')
require('beps.colorscheme')

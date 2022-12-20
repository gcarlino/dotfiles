require("beps.options")
require("beps.disable_builtin")
require("beps.keymaps")

-- lewis6991/impatient.nvim 
require('impatient')

require("beps.packer")
-- plugin sepcific configurations in ./after/plugin/ folder

if vim.fn.has("mac") == 1 then
    require("beps.mac")
end

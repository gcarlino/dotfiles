require("beps.options")
require("beps.disable_builtin")
require("beps.keymaps")

require("beps.plugins")
-- plugin sepcific configurations in ./after/plugin/ folder

if vim.fn.has("mac") == 1 then
    require("beps.mac")
end

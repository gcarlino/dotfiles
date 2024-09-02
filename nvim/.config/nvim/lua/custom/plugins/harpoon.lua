return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        vim.keymap.set("n", "<localleader>ha", function()
            harpoon:list():add()
        end,
            { desc = "[H]harpoon [a]dd" })
        vim.keymap.set("n", "<localleader>hl", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
            { desc = "[H]arpoon [l]ist" }
        )

        -- Set <space>1..<space>5 be my shortcuts to moving to the files
        for _, idx in ipairs { 1, 2, 3, 4, 5 } do
            vim.keymap.set("n", string.format("<localleader>%d", idx), function()
                harpoon:list():select(idx)
            end)
        end
    end,
}

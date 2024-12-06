-- terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a new terminal at the bottom of the screen
vim.keymap.set("n", "<leader>tt",
    function()
        vim.cmd.new()
        vim.cmd.wincmd "J"
        -- Fixed height
        vim.api.nvim_win_set_height(0, 12)
        vim.wo.winfixheight = true
        vim.cmd.term()
        vim.cmd(":startinsert")
    end,
    { desc = "Open terminal" }
)

-- Leave terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Initialise buffer and window table
local state = {
    terminal = {
        buf = -1,
        win = -1,
    }
}

-- Open window split below 
local function open_window_below (opts)
    opts = opts or {}

    local height = opts.height or math.floor(vim.o.lines * 0.33)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- Config split window below
    local win_config = {
        height = height,
        split = 'below',
    }

    -- Create the window split below
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { win = win, buf = buf }
end

-- Toggle terminal
local toggle_terminal = function ()
    -- check if window exists
    if not vim.api.nvim_win_is_valid(state.terminal.win) then
        -- create window
        state.terminal = open_window_below( { buf = state.terminal.buf } )
        -- Check if the buffer type is terminal
        if vim.bo[state.terminal.buf].buftype ~= "terminal" then
            -- create terminal if it does not existe
            vim.cmd.terminal()
        end
        -- Go to insert mode in terminal
        vim.cmd.startinsert()
    else
        -- Hide window
        vim.api.nvim_win_hide(state.terminal.win)
    end
end

-- Toggle terminal at the bottom of the screen
vim.keymap.set( { "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Toggle terminal" })

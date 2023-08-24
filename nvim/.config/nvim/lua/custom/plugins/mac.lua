if vim.fn.has('mac') == 0 then
    return {}
else
    return {
        {
            'mrjones2014/dash.nvim',
            build = 'make install',
            enabled = false,
            event = "VeryLazy",
        },
    }
end

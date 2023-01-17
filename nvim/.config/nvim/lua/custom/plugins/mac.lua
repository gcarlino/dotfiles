if not vim.fn.has('mac') == 1 then
    return
end

return {
    {
        'mrjones2014/dash.nvim',
        build = 'make install',
        event = "VeryLazy"
    },
    {
        'epwalsh/obsidian.nvim',
        event = 'VeryLazy',
        config = function ()
            require("obsidian").setup({
                dir = "~/Simularia/Notes",
                completion = {
                    nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
                },
                disable_frontmatter = true,
            })
        end
    },
}

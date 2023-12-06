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

        {
            "epwalsh/obsidian.nvim",
            version = "*",
            lazy = true,
            ft = "markdown",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "hrsh7th/nvim-cmp",
            },
            opts = {
                workspaces = {
                    {
                        name = "Simularia",
                        path= "~/Simularia/Notes/",
                    },
                },
                completion = {
                    nvim_cmp = true,
                    -- prepend_note_id = false,
                },
                open_app_foreground = true,
            }
        },
    }
end

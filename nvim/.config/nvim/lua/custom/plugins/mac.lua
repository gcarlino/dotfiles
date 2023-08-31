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
            lazy = true,
            event = { "BufReadPre /Users/beps/Simularia/Notes/**.md" },
            dependencies = {
                "nvim-lua/plenary.nvim",
                "hrsh7th/nvim-cmp",
            },
            opts = {
                dir = "~/Simularia/Notes/",
                mappings = {
                    -- ["gf"] = require("obsidian.mapping").gf_passthrough(),
                },
                completion = {
                    nvim_cmp = true,
                    prepend_note_id = false,
                },
                open_app_foreground = true,
            }
        }
    }
end

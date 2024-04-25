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
            -- event = {
            --     "BufReadPre " .. vim.fn.expand "~" .. "/Simularia/Notes/**.md",
            --     "BufNewFile " .. vim.fn.expand "~" .. "/Simularia/Notes/**.md",
            -- },
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
                    {
                        name = "no-vault",
                        path = function ()
                            return assert(vim.fn.getcwd())
                        end,
                        overrides = {
                            notes_subdir = vim.NIL,
                            new_notes_location = "current_dir",
                            templates = {
                                subdir = vim.NIL,
                            },
                            disable_frontmatter = true,
                        }
                    }
                },
                completion = {
                    nvim_cmp = true,
                    -- prepend_note_id = false,
                },
                ui = {
                    enable = false
                },
                disable_frontmatter = true,
                open_app_foreground = true,
                follow_url_func = function(url)
                    -- Open the URL in the default web browser.
                    vim.fn.jobstart({"open", url})  -- Mac OS
                    -- vim.fn.jobstart({"xdg-open", url})  -- linux
                end,

            }
        },
    }
end

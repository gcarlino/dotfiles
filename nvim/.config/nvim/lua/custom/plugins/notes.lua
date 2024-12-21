return {
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        build = false,
        opts = {
            backend = "kitty",
            processor = "magick_cli",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            window_overlap_clear_enabled = true,
        }
    },

    {
        'mrjones2014/dash.nvim',
        cond = function()
            return vim.fn.has("mac") == 1
        end,
        build = 'make install',
        enabled = false,
        event = "VeryLazy",
    },

    {
        "epwalsh/obsidian.nvim",
        event = "VeryLazy",
        cond = function()
            return vim.fn.has("mac") == 1
        end,
        version = "*",
        keys = {
            { '<leader>oo', ':ObsidianOpen<CR>', desc = '[O]pen [O]bsidian' },
            { '<leader>on', ':ObsidianNew<CR>', desc = '[O]bsidian [N]ew' },
            { '<leader>ob', ':ObsidianBacklinks<CR>', desc = '[O]bsidian [B]acklinks' },
            { '<leader>os', ':ObsidianSearch<CR>', desc = '[O]bsidian [S]earch' },
            { '<leader>ot', ':ObsidianTemplate<CR>', desc = '[O]bsidian [T]emplate' },
            { '<leader>ow', ':ObsidianWorkspace<CR>', desc = '[O]bsidian [W]orkspace' },
            { '<leader>op', ':ObsidianPasteImg<CR>', desc = '[O]bsidian [P]aste image' },
            { '<leader>oc', ':ObsidianToggleCheckbox<CR>', desc = '[O]bsidian toggle [C]heckbox' },
            { '<leader>oi', ':ObsidianPasteImg<CR>', desc = '[O]bsidian paste [I]mage' },
            { '<leader>of', ':ObsidianTags<CR>', desc = '[O]bsidian [F]ind tags' },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            workspaces = {
                {
                    name = "Simularia",
                    path = "~/Simularia/Notes/",
                },
                {
                    name = "Contatti",
                    path = "~/Simularia/Contatti/",
                },
                {
                    name = "no-vault",
                    path = function()
                        return assert(vim.fn.getcwd())
                    end,
                    overrides = {
                        notes_subdir = vim.NIL,
                        new_notes_location = "current_dir",
                        disable_frontmatter = true,
                    }
                }
            },
            templates = {
                folder = "~/Simularia/Notes/templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
            },
            -- completion = {
            --     nvim_cmp = true,
            -- },
            ui = {
                enable = true
            },
            mappings = {
                ["gf"] = {
                    action = function ()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                ["<cr>"] = {
                    action = function ()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                }
            },
            disable_frontmatter = true,
            open_app_foreground = true,
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,

        }
    },

    {
        "OXY2DEV/markview.nvim",
        enabled = false,
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            modes = { "no" },
        },
    },
}

local M = {}

-- Edit my notes
function M.search_mynotes()
    require('telescope.builtin').live_grep {
        -- path_display = "tail",
        cwd = "~/Simularia/Notes",
        prompt_title = "~ (Not only) Simularia Notes ~",
        layout_strategy = "horizontal",
    }
end

-- Edit nvim configuration files
function M.edit_nvim()
    require('telescope.builtin').find_files {
        cwd = "~/.dotfiles/nvim/.config/nvim/",
        prompt_title = "~ Edit nvim ~",
        layout_strategies = "horizontal",
    }
end

-- Edit dotfiles
function M.edit_dotfiles()
    require('telescope.builtin').git_files {
        cwd = "~/.dotfiles/",
        prompt_title = "~ Edit dotfiles ~",
        layout_strategies = "horizontal",
    }
end

-- Edit packages
-- TODO
-- 
return M

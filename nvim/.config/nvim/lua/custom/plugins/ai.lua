return {

    {
        "David-Kunz/gen.nvim",
        cond = function ()
            return vim.fn.has("mac") == 1
        end,
        event = "VeryLazy",
        -- lazy = false,

        config = function()
            require('gen').setup({
                model = "gemma2:27b",
                host = "localhost",
                port = "11434",
                quit_map = "q",
                retry_map = "<c-r>",
                init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
                command = function(options)
                    local body = {model = options.model, stream = true}
                    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
                end,
                display_mode = "float", -- Can be "float" or "split" or "horizontal-split".
                show_prompt = false,
                show_model = true,
                no_auto_close = false,
                debug = false
            })

            -- Keymaps
            vim.keymap.set({'n', 'v'}, '<localleader>op', ':Gen<CR>', {desc = "Ollama prompt"})
            vim.keymap.set({'n'}, '<localleader>om', function () require('gen').select_model() end, {desc = "Ollama select model"})

            -- Custom prompts
            require('gen').prompts['Make_Scientific'] =
                { prompt = 'Transform the following text into the style of a scientific paper and do not add any explanation:\n$text', replace = true }
        end
    },

}

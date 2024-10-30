return {

    {
        "David-Kunz/gen.nvim",
        cond = function()
            return false
            -- return vim.fn.has("mac") == 1
        end,
        event = "VeryLazy",
        keys = {
            { "<localleader>op", ":Gen<CR>",                                    desc = "Ollama prompt",      mode = { 'n', 'v' } },
            { "<localleader>om", function() require("gen").select_model() end,  desc = "Ollama select model" }
        },
        opts = {
            model = "gemma2:27b",
            quit_map = "q",
            retry_map = "<c-r>",
            accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
            host = "localhost",
            port = "11434",
            display_mode = "float",
            show_prompt = false,
            show_model = true,
            no_auto_close = false, -- Never closes the window automatically.
            hidden = false,        -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
            init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
            -- Function to initialize Ollama
            command = function(options)
                local body = { model = options.model, stream = true }
                return "curl --silent --no-buffer -X POST http://" ..
                options.host .. ":" .. options.port .. "/api/chat -d $body"
            end,
            -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
            -- This can also be a command string.
            -- The executed command must return a JSON object with { response, context }
            -- (context property is optional).
            -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            debug = false -- Prints errors and the command which is run.
        },
        config = function()
            -- Custom prompts
            require('gen').prompts['Make_Scientific'] =
            { prompt =
            'Transform the following text into the style of a scientific paper and do not add any explanation:\n$text', replace = true }
        end
    },

}

-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize avante.nvim

-- @type LazySpec
-- API Check: https://check.crond.dev/
return {
  "yetone/avante.nvim",
  -- event = "VeryLazy",  -- lazy event
  event = "User AstroFile", -- astroNvim event
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- add any opts here
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    -- NOTE: claude
    -- provider = "claude", -- Recommend using Claude
    -- auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    -- NOTE: copilot
    ---@type AvanteSupportedProvider
    claude = {
      endpoint = "https://api.burn.hair",
      model = "claude-3-7-sonnet-20250219",
      temperature = 1,
      max_tokens = 20000,
      thinking = {
        type = "enabled",
        budget_tokens = 3000,
      },
    },
    openai = {
      endpoint = "https://api.theoremhub.asia/v1",
      model = "claude-3.5-sonnet",
      temperature = 0,
      max_tokens = 4096,
    },
    copilot = {
      -- endpoint = "https://api.githubcopilot.com",
      -- model = "claude-3.5-sonnet", -- 20250221: claude 3.5 不能访问他不认识的 file_type: Error: 'API request failed with status 500. Body: "Internal Server Error"'
      -- model = "claude-3.7-sonnet-thought",
      model = "claude-3.7-sonnet",
      -- model = "DeepSeek-R1",
      -- model = "gpt-4o",
      -- model = "claude-3-5-sonnet-coder", -- 不存在
      -- model = "gemini-2.0-flash-001",
      -- model = "o3-mini-paygo", -- 不可用
      -- model = "o3-mini",
      -- model = "o1",
      
      -- proxy = "http://127.0.1.1:7890", -- [protocol://]host[:port] Use this proxy
      -- allow_insecure = false, -- Allow insecure server connections
      timeout = 60000, -- Timeout in milliseconds
      temperature = 1,
      max_tokens = 50000,
      -- thinking = {
      --   type = "enabled",
      --   budget_tokens = 2048,
      -- },
      -- disable_tools = false,
      display_name = "copilot claude 3.7 thinking and tools",
    },
    -- NOTE: Custom providers
    vendors = {
      ---@type AvanteProvider
      ---["my-custom-provider"] = {
      --   endpoint = "https://api.openai.com/v1/chat/completions", -- The full endpoint of the provider
      --   model = "gpt-4o", -- The model name to use with this provider
      --   api_key_name = "OPENAI_API_KEY", -- The name of the environment variable that contains the API key
      --   --- This function below will be used to parse in cURL arguments.
      --   --- It takes in the provider options as the first argument, followed by code_opts retrieved from given buffer.
      --   --- This code_opts include:
      --   --- - question: Input from the users
      --   --- - code_lang: the language of given code buffer
      --   --- - code_content: content of code buffer
      --   --- - selected_code_content: (optional) If given code content is selected in visual mode as context.
      --   ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
      --   parse_curl_args = function(opts, code_opts) end
      --   --- This function will be used to parse incoming SSE stream
      --   --- It takes in the data stream as the first argument, followed by SSE event state, and opts
      --   --- retrieved from given buffer.
      --   --- This opts include:
      --   --- - on_chunk: (fun(chunk: string): any) this is invoked on parsing correct delta chunk
      --   --- - on_complete: (fun(err: string|nil): any) this is invoked on either complete call or error chunk
      --   ---@type fun(data_stream: string, event_state: string, opts: ResponseParser): nil
      --   parse_response = function(data_stream, event_state, opts) end
      --   --- The following function SHOULD only be used when providers doesn't follow SSE spec [ADVANCED]
      --   --- this is mutually exclusive with parse_response_data
      --   ---@type fun(data: string, handler_opts: AvanteHandlerOptions): nil
      --   parse_stream_data = function(data, handler_opts) end
      -- }
      ["cursor2api-c3.5-200k"] = {
        __inherited_from = "openai",
        endpoint = "https://cursor.toapis.org",
        api_key_name = "CURSOR2API_API_KEY",
        model = "claude-3-5-sonnet-200k",
        display_name = "cursor to api: claude 3.5 200k"
      },
      ["cursor2api-c3.7thinking"] = {
        __inherited_from = "openai",
        endpoint = "https://cursor.toapis.org",
        api_key_name = "CURSOR2API_API_KEY",
        model = "claude-3.7-sonnet-thinking",
        thinking = {
          type = "enabled",
          budget_tokens = 2048,
        },
        disable_tools = false,
        display_name = "cursor to api: claude 3.7 thinking and tools"
      },
      ["cursor2api-c3.7"] = {
        __inherited_from = "openai",
        endpoint = "https://cursor.toapis.org",
        api_key_name = "CURSOR2API_API_KEY",
        model = "claude-3.7-sonnet",
        display_name = "cursor to api: claude 3.7"
      },
      -- WARN: "https://api.theoremhub.asia/v1" 疑似降智
      theoremhub = {
        __inherited_from = "openai",
        endpoint = "https://api.theoremhub.asia/v1",
        api_key_name = "THEOREMHUB_API_KEY",
        model = "claude-3.7-sonnet",
      },
      ["ephone_claude3.7"] = {
        __inherited_from = "openai",
        endpoint = "https://api.ephone.ai/v1",
        api_key_name = "EPHONE_API_KEY",
        -- model = "claude-3-5-sonnet-20241022",
        -- model = "grok-3-reasoner",
        model = "claude-3-7-sonnet-20250219",
        display_name = "ephone claude-3-7-sonnet-20250219"
      },
      ["ephone_claude3.5_coder"] = {
        __inherited_from = "openai",
        endpoint = "https://api.ephone.ai/v1",
        api_key_name = "EPHONE_API_KEY",
        model = "claude-3-5-sonnet-coder",
        display_name = "ephone claude-3-5-sonnet-coder"
      },
      burnhair = {
        __inherited_from = "openai",
        endpoint = "https://api.burn.hair/v1",
        api_key_name = "BURNHAIR_API_KEY",
        model = "claude-3-5-sonnet-20241022",
      },
      aicnn = {
        __inherited_from = "openai",
        endpoint = "https://api.aicnn.cn/v1",
        api_key_name = "AICNN_API_KEY",
        model = "claude-3-5-sonnet-coder",
        -- model = "claude-3-7-sonnet-20250219",
        -- model = "grok-3-re",
        -- model = "deepseek-reasoner-all",
        -- model = "claude-3-5-sonnet-all",
        -- model = "grok-3-reasoner-re",
      },
      voapi = {
        __inherited_from = "openai",
        endpoint = "https://free40.fly.dev/v1",
        api_key_name = "VOAPI_API_KEY",
        -- model = "claude-3-5-sonnet-coder",
        -- model = "claude-3-5-sonnet-20241022",
        model = "deepseek-r1",
      },
      xai = {
        __inherited_from = "openai",
        -- endpoint = "https://api.x.ai/v1/chat/completions",
        endpoint = "https://api.x.ai/v1",
        api_key_name = "XAI_API_KEY",
        model = "grok-2-vision-latest",
        -- model = "grok-2-latest",
      },
      groq = {
        __inherited_from = "openai",
        -- endpoint = "https://api.groq.com/openai/v1/chat/completions",
        endpoint = "https://api.groq.com/openai/v1",
        api_key_name = "GROQ_API_KEY",
        model = "qwen-2.5-coder-32b",
        -- model = "llama-3.3-70b-versatile",
        -- model = "deepseek-r1-distill-qwen-32b",
        -- model = "deepseek-r1-distill-llama-70b",
      },
    },
    cursor_applying_provider = "groq", -- 遍历文件插入，需要响应速度快的 provider
    provider = "copilot", -- Recommend using Claude
    auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    web_search_engine = {
      provider = "tavily", -- tavily or serpapi
    },

    --Specify the behaviour of avante.nvim
    --1. auto_apply_diff_after_generation: Whether to automatically apply diff after LLM response.
    --                                     This would simulate similar behaviour to cursor. Default to false.
    --2. auto_set_keymaps                : Whether to automatically set the keymap for the current line. Default to true.
    --                                     Note that avante will safely set these keymap. See https://github.com/yetone/avante.nvim/wiki#keymaps-and-api-i-guess for more details.
    --3. auto_set_highlight_group        : Whether to automatically set the highlight group for the current line. Default to true.
    --4. support_paste_from_clipboard    : Whether to support pasting image from clipboard. This will be determined automatically based whether img-clip is available or not.
    behaviour = {
      auto_suggestions = true, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = true,
      support_paste_from_clipboard = true,
      enable_cursor_planning_mode = false,
    },
    mappings = {
      ---@class AvanteConflictMappings

      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-m>",
        next = "<M-n>",
        prev = "<M-N>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-j>",
        -- insert = "<C-CR>",
        -- NOTE: 20241023 在 windows terminal 中等于Ctrl + enter,
        -- showkey -a 命令可以查看具体的按键序列(ps: 记得退出 tmux 环境,否则一些按键会被拦截)
        -- 其他类似命令：
        --                sed -n l
        --                cat -v
      },
      -- NOTE: The following will be safely set by avante.nvim
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      focus = "<leader>af",
      toggle = {
        default = "<leader>at",
        debug = "<leader>ad",
        hint = "<leader>ah",
        suggestion = "<leader>as",
        repomap = "<leader>aR",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
      files = {
        add_current = "<leader>ac", -- Add current buffer to selected files
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "zbirenbaum/copilot.lua",
      opts = {
        copilot_node_command = vim.fn.expand "$HOME" .. "/.nvm/versions/node/v18.20.4/bin/node", -- 不同机器需要修改
      },
    }, -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
    -- neo-tree 添加 file 到 avante ask 可选项
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,  -- 标记为可选依赖，如果不存在不会报错
      opts = function (_, opts)
        local ok, _ = pcall(require, "neo-tree")
        if not ok then return opts end  -- 如果neo-tree不存在，直接返回原始选项
        return require("astrocore").extend_tbl(opts, {
          filesystem = {
            commands = {
              avante_add_files = function(state)
                local node = state.tree:get_node()
                local filepath = node:get_id()
                local relative_path = require("avante.utils").relative_path(filepath)
                
                local sidebar = require("avante").get()

                local open = sidebar:is_open()
                -- ensure avante sidebar is open
                if not open then
                  require("avante.api").ask()
                  sidebar = require("avante").get()
                end

                sidebar.file_selector:add_selected_file(relative_path)

                -- remove neo tree buffer
                if not open then sidebar.file_selector:remove_selected_file "neo-tree filesystem [1]" end
              end,
            },
            window = {
              mappings = {
                ["oa"] = "avante_add_files",
              },
            },
          },
        })
      end,
    },
  },
}

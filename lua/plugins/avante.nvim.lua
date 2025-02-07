-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize avante.nvim

-- @type LazySpec
-- API Check: https://check.crond.dev/
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
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
      endpoint = "https://burn.hair/",
      model = "claude-3-5-sonnet-20241022",
      temperature = 0,
      max_tokens = 4096,
    },
    openai = {
      endpoint = "https://api.theoremhub.asia/v1",
      model = "claude-3.5-sonnet",
      temperature = 0,
      max_tokens = 4096,
    },
    copilot = {
      -- endpoint = "https://api.githubcopilot.com",
      -- NOTE:  claude-3.5-sonnet,o1-preview-2024-09-12,o1-mini-2024-09-12,o1-mini(Preview),o1-preview(Preview),gpt-4o
      model = "claude-3.5-sonnet",
      -- proxy = "http://127.0.1.1:7890", -- [protocol://]host[:port] Use this proxy
      -- allow_insecure = false, -- Allow insecure server connections
      -- timeout = 30000, -- Timeout in milliseconds
      -- temperature = 0,
      -- max_tokens = 4096,
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
      -- WARN: "https://api.theoremhub.asia/v1" 疑似降智
      theoremhub = {
        __inherited_from = "openai",
        endpoint = "https://api.theoremhub.asia/v1",
        api_key_name = "THEOREMHUB_API_KEY",
        model = "claude-3.5-sonnet",
      },
      ephone = {
        __inherited_from = "openai",
        endpoint = "https://api.ephone.ai/v1",
        api_key_name = "EPHONE_API_KEY",
        model = "claude-3-5-sonnet-20241022",
      },
      burnhair = {
        __inherited_from = "openai",
        endpoint = "https://api.burn.hair/v1",
        api_key_name = "BURNHAIR_API_KEY",
        model = "claude-3-5-sonnet-20241022",
      }
    },
    provider = "copilot", -- Recommend using Claude
    auto_suggestions_provider = "burnhair", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    -- NOTE: openai
    -- provider = "openai", -- Recommend using Claude
    -- auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    ---@type AvanteSupportedProvider
    -- openai = {
    --   endpoint = "https://burn.hair/v1",
    --   model = "gpt-4o",
    --   timeout = 30000, -- Timeout in milliseconds
    --   temperature = 0,
    --   max_tokens = 4096,
    --   ["local"] = false, -- local： 本地 LLM
    -- },

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
      support_paste_from_clipboard = false,
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
        next = "<M-]>",
        prev = "<M-[>",
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
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
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
  },
}

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
    gemini = {
      -- model = "gemini-2.5-pro-exp-03-25",
      model = "gemini-2.5-pro-exp-03-25",
      temperature = 1.5,
      max_tokens = 20000,
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
      -- disable_tools = true,
      -- disable_tools = { "git_diff", "git_commit" },
      display_name = "copilot claude 3.7 sonnet",
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
        display_name = "cursor to api: claude 3.5 200k",
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
        display_name = "cursor to api: claude 3.7 thinking and tools",
      },
      ["cursor2api-c3.7"] = {
        __inherited_from = "openai",
        endpoint = "https://cursor.toapis.org",
        api_key_name = "CURSOR2API_API_KEY",
        model = "claude-3.7-sonnet",
        display_name = "cursor to api: claude 3.7",
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
        display_name = "ephone claude-3-7-sonnet-20250219",
      },
      ["ephone_claude3.5_coder"] = {
        __inherited_from = "openai",
        endpoint = "https://api.ephone.ai/v1",
        api_key_name = "EPHONE_API_KEY",
        model = "claude-3-5-sonnet-coder",
        display_name = "ephone claude-3-5-sonnet-coder",
      },
      burnhair = {
        __inherited_from = "claude",
        endpoint = "https://api.burn.hair",
        api_key_name = "BURNHAIR_API_KEY",
        model = "claude-3-7-sonnet-20250219",
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
      openRouter = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "google/gemini-2.5-pro-exp-03-25:free",
      },
      deepsider = {
        __inherited_from = "openai",
        endpoint = "https://msdone1-deepsider2api.hf.space/v1",
        api_key_name = "HUGGING_FACE_API_KEY",
        model = "anthropic/claude-3.7-sonnet",
        -- "deepseek/deepseek-r1",
        -- "deepseek/deepseek-chat", # deepseek-v3
        -- "deepseek/deepseek-chat-v3-0324", # deepseek-v3-0324
        -- "qwen/qwq-32b", # thinking
        -- "qwen/qwen-max",
        -- "openai/gpt-4o",
        -- "openai/o1",
        -- "openai/o3-mini",
        -- "openai/gpt-4o-mini",
        -- "openai/gpt-4o-image",
        -- "x-ai/grok-3",
        -- "x-ai/grok-3-reasoner",
        -- "anthropic/claude-3.7-sonnet",
        -- "anthropic/claude-3.5-sonnet",
        -- "google/gemini-2.0-flash",
        -- "google/gemini-2.0-pro-exp-02-05",
        -- "google/gemini-2.0-flash-thinking-exp-1219",
      },
      ["copilot-claude3.5"] = {
        __inherited_from = "copilot",
        model = "claude-3.5-sonnet",
        display_name = "copilot claude 3.5 sonnet",
      },
      ["copilot-claude3.7-thinking"] = {
        __inherited_from = "copilot",
        model = "claude-3.7-sonnet-thought",
        display_name = "copilot claude 3.7 sonnet thinking",
        thinking = {
          type = "enabled",
          budget_tokens = 2048,
        },
      },
    },
    cursor_applying_provider = "groq", -- 遍历文件插入，需要响应速度快的 provider
    provider = "copilot", -- Recommend using Claude
    auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
    -- disabled_tools = { "git_diff", "git_commit" },
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
      enable_claude_text_editor_tool_mode = false,
    },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 30, -- default % based on available width
      sidebar_header = {
        enabled = true, -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = false, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "theirs", -- which diff to focus after applying
      },
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
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
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
        copilot_node_command = (vim.fn.has "wsl" == 1 and vim.fn.hostname() == "OpenValley-LWT")
            and (vim.fn.expand "$HOME" .. "/.nvm/versions/node/v23.0.0/bin/node")
          or nil, -- 仅在 WSL 并且主机名为 open 时设置
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
      optional = true,
      opts = {
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
        },
        window = {
          mappings = {
            ["oa"] = "avante_add_files",
          },
        },
      },
    },
    {
      "ravitemer/mcphub.nvim",
      -- Ensure these are installed as they're required by most MCP servers
      -- node --version    # Should be >= 18.0.0
      -- python --version  # Should be installed
      -- uvx --version    # Should be installed
      -- npx --version    # Should be installed
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
      },
      -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
      build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
      config = function()
        -- 创建配置目录（如果不存在）
        local config_dir = vim.fn.stdpath "config" .. "/lua/mcphub"
        local config_path = config_dir .. "/mcpservers.json"

        -- 确保目录存在
        vim.fn.mkdir(config_dir, "p")

        -- 从环境变量读取 API 密钥，如果不存在则为空
        local amap_api_key = os.getenv "AMAP_MAPS_API_KEY" or ""
        local notion_api_key = os.getenv "NOTION_INTEGRATION_TOKEN" or ""

        -- 创建配置文件内容
        local config_content = vim.fn.json_encode {
          mcpServers = {
            ["github.com/modelcontextprotocol/servers/tree/main/src/git"] = {
              command = "uvx",
              name = "Git Tools",
              args = { "mcp-server-git", "--repository", vim.fn.getcwd() },
              description = "A Model Context Protocol server for Git repository interaction and automation",
            },
            ["amap-maps"] = {
              command = "npx",
              name = "amap-maps",
              description = "MCP server for using the AMap Maps API.(install by <npm install -g @amap/amap-maps-mcp-server>)",
              args = { "-y", "@amap/amap-maps-mcp-server" },
              env = {
                AMAP_MAPS_API_KEY = amap_api_key,
              },
            },
            ["notion-mcp-server"] = {
              command = "npx",
              name = "notion-mcp-server",
              description = "MCP server for Notion integration.(install by <npm install -g @orbit-logistics/notion-mcp-server>)",
              args = { "-y", "@orbit-logistics/notion-mcp-server", "-t", notion_api_key },
            },
            ["mcp=hfspace"] = {
              command = "npx",
              args = {
                "-y",
                "@llmindset/mcp-hfspace",
              },
            },
          },
        }

        -- 写入配置文件
        local file = io.open(config_path, "w")
        if file then
          file:write(config_content)
          file:close()
        else
          vim.notify("无法创建 MCPHub 配置文件", vim.log.levels.ERROR)
        end
        
        require("mcphub").setup {
          -- Required options
          port = 3000, -- Port for MCP Hub server
          config = config_path, -- Config file in neovim config directory

          -- Optional options
          on_ready = function(hub)
            -- Called when hub is ready
          end,
          on_error = function(err)
            -- Called on errors
            vim.notify(err, vim.log.levels.DEBUG)
            local errors = require("mcphub").get_state().errors.items
            local server_names = {}
            local server_configs = require("mcphub").get_state().servers_config

            -- 先显示配置信息便于调试
            vim.notify(vim.inspect(server_configs), vim.log.levels.DEBUG)

            -- 收集出现错误的服务器名称
            for _, err in ipairs(errors) do
              if err.details and err.details.server then table.insert(server_names, err.details.server) end
            end

            -- 处理出错的服务器
            if #server_names > 0 then
              vim.notify("检测到以下MCP服务器出错: " .. table.concat(server_names, ", "), vim.log.levels.WARN)

              -- 为每个出错的服务器检查并安装依赖
              for _, server_name in ipairs(server_names) do
                local config = server_configs[server_name]
                if config then
                  local command = config.command
                  local package_name = nil

                  -- 提取包名
                  if command == "npx" and config.args and #config.args >= 2 then
                    -- 对于npx命令，第二个参数通常是包名
                    package_name = config.args[2]
                    if package_name:sub(1, 1) == "@" then
                      -- 处理范围包
                      package_name = package_name
                    end
                  elseif command == "uvx" and config.args and #config.args >= 1 then
                    -- 对于uvx命令，第一个参数通常是包名
                    package_name = config.args[1]
                  end

                  if package_name then
                    vim.notify("正在检查 " .. server_name .. " 依赖: " .. package_name, vim.log.levels.INFO)
                    -- 首先检查依赖是否已安装
                    local check_cmd = nil
                    if command == "npx" then
                      -- 对于 npm 包，检查是否已安装
                      check_cmd = "npm list -g " .. package_name .. " --depth=0"
                    elseif command == "uvx" then
                      -- 对于 Python 包，检查是否已安装
                      check_cmd = "uv pip show " .. package_name .. " --python ~/.mcp-hub/cache/.venv/bin/python"
                    end

                    vim.fn.jobstart(check_cmd, {
                      on_exit = function(_, code)
                        -- 如果退出代码不为0，则表示依赖未安装
                        if code ~= 0 then
                          vim.notify(package_name .. " 未安装，正在安装...", vim.log.levels.INFO)

                          -- 创建安装命令
                          local install_cmd = nil
                          if command == "npx" then
                            install_cmd = "npm install -g " .. package_name
                          elseif command == "uvx" then
                            install_cmd = "uv pip install " .. package_name .. " --python ~/.mcp-hub/cache/.venv/bin/python"
                          end

                          -- 执行安装命令
                          if install_cmd then
                            vim.notify("执行: " .. install_cmd, vim.log.levels.INFO)
                            vim.fn.jobstart(install_cmd, {
                              on_exit = function(_, code)
                                if code == 0 then
                                  vim.notify(package_name .. " 已成功安装", vim.log.levels.INFO)
                                  -- 安装成功后尝试重启MCP Hub
                                  vim.defer_fn(function()
                                    local hub = require("mcphub").get_hub_instance()
                                    if hub then
                                      hub:restart(nil)
                                      vim.notify("已尝试重启 MCP Hub", vim.log.levels.INFO)
                                    end
                                  end, 1000)
                                else
                                  vim.notify(
                                    package_name .. " 安装失败，错误码: " .. code,
                                    vim.log.levels.ERROR
                                  )
                                end
                              end,
                              on_stdout = function(_, data)
                                if data and #data > 0 then
                                  vim.notify("安装输出: " .. table.concat(data, "\n"), vim.log.levels.DEBUG)
                                end
                              end,
                              on_stderr = function(_, data)
                                if data and #data > 0 then
                                  vim.notify("安装错误: " .. table.concat(data, "\n"), vim.log.levels.WARN)
                                end
                              end,
                            })
                          end
                        end
                      end,
                    })
                  end
                else
                  vim.notify("无法找到服务器 " .. server_name .. " 的配置信息", vim.log.levels.ERROR)
                end
              end
            end
          end,
          log = {
            level = vim.log.levels.WARN,
            to_file = false,
            file_path = nil,
            prefix = "MCPHub",
          },
        }
      end,
    },
  },
}

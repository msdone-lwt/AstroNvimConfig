-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

-- NOTE: common function

--[[
 helper function for utf8 chars
 * 获取字符串中指定位置的字符长度
 * @param {string} s 字符串
 * @param {number} pos 位置
 * @returns {number} 字符长度
 ]]
local function getCharLen(s, pos)
  local byte = string.byte(s, pos)
  -- vim.notify_once(s .. ":" .. pos .. ":" .. byte)
  if not byte then return nil end
  return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

--[[
  * 判断字符串是否为空
  * @param {string} str 字符串
  * @returns {boolean} 是否为空
 ]]
local function whitespace_only(str) return str:match "^%s*$" ~= nil end

--[[
  * 去除字符串两端的空白字符
  * @param {string} str 字符串
  * @returns {string} 去除两端空白字符后的字符串
 ]]
local function trim(str) return (string.gsub(str, "^%s*(.-)%s*$", "%1")) end

--[[
  * 将字符串写入到 Home 目录下的文件中
  * @param {string} filename 文件名
  * @param {string} content 内容
 ]]
local function write_to_file_in_home(filename, content)
  -- 获取 Home 目录路径
  local home = os.getenv "HOME" or os.getenv "USERPROFILE"
  if not home then
    vim.notify_once("Error: Cannot determine home directory", vim.log.levels.ERROR)
    return
  end

  -- 构建完整的文件路径
  local full_path = home .. "/" .. filename

  -- 打开文件，使用 "w" 模式以写入内容
  local file, err = io.open(full_path, "w")
  if not file then
    vim.notify_once("Error opening file: " .. err, vim.log.levels.ERROR)
    return
  end

  -- 写入内容并关闭文件
  file:write(content .. "\n")
  file:close()
end
--[[
  * 将 table 转换为字符串
  * @param {table} tbl table
  * @param {number} indent 缩进
  * @returns {string} 转换后的字符串
 ]]
local function table_to_string(tbl, indent)
  indent = indent or 0
  local toprint = string.rep(" ", indent) .. "{\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if type(k) == "number" then
      toprint = toprint .. "[" .. k .. "] = "
    elseif type(k) == "string" then
      toprint = toprint .. k .. " = "
    end
    if type(v) == "number" then
      toprint = toprint .. v .. ",\n"
    elseif type(v) == "string" then
      toprint = toprint .. '"' .. v .. '",\n'
    elseif type(v) == "table" then
      toprint = toprint .. table_to_string(v, indent + 2) .. ",\n"
    else
      toprint = toprint .. '"' .. tostring(v) .. '",\n'
    end
  end
  toprint = toprint .. string.rep(" ", indent - 2) .. "}"
  return toprint
end

---@type LazySpec
return {
  --
  -- -- == Examples of Adding Plugins ==
  --
  -- "andweeb/presence.nvim", -- Discord 插件，用于显示当前正在编辑的文件
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },
  --
  -- -- == Examples of Overriding Plugins ==
  --
  -- -- customize alpha options
  -- {
  --   "goolord/alpha-nvim",
  --   opts = function(_, opts)
  --     -- customize the dashboard header
  --     opts.section.header.val = {
  --       " █████  ███████ ████████ ██████   ██████",
  --       "██   ██ ██         ██    ██   ██ ██    ██",
  --       "███████ ███████    ██    ██████  ██    ██",
  --       "██   ██      ██    ██    ██   ██ ██    ██",
  --       "██   ██ ███████    ██    ██   ██  ██████",
  --       " ",
  --       "    ███    ██ ██    ██ ██ ███    ███",
  --       "    ████   ██ ██    ██ ██ ████  ████",
  --       "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
  --       "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
  --       "    ██   ████   ████   ██ ██      ██",
  --     }
  --     return opts
  --   end,
  -- },
  --
  -- -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  --
  -- -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  --
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  {
    "goolord/alpha-nvim",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        {
          "juansalvatore/git-dashboard-nvim",
          dependencies = { "nvim-lua/plenary.nvim" },
        },
      },
    },
    config = function()
      local dashboard = require "alpha.themes.dashboard"
      local startify = require "alpha.themes.startify"

      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "🚀 Neovim loaded "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"

      local function pad(n) return { type = "padding", val = n } end

      --[[
        * 将字符串中的不可见字符替换为可见字符
        * @param {string} str 字符串
        * @returns {string} 替换后的字符串
      ]]
      local function replace_invisible_chars_in_table(tbl)
        local replacements = {
          ["\u{00A0}"] = " ", -- 不间断空格
          ["\u{200B}"] = "", -- 零宽空格
          -- 可以根据需要添加更多替换规则
        }

        local function replace_invisible_chars(str)
          for invisible_char, replacement in pairs(replacements) do
            str = str:gsub(invisible_char, replacement)
          end
          return str
        end

        for i, str in ipairs(tbl) do
          tbl[i] = replace_invisible_chars(str)
        end

        return tbl
      end

      -- 定义替换函数
      local function replace_numbers(input_str)
        -- 使用 gsub 函数进行替换
        local replaced_str = input_str:gsub("%d", function(digit)
          if digit == "0" then
            -- return ""
            return "󱓼"
          else
            -- return ""
            return "󱓻"
          end
        end)
        return { replaced_str }
      end

      -- 定义替换函数
      local function replace_strings(input_str)
        -- 使用 gsub 函数进行替换
        local replaced_str = input_str:gsub("%a", "s")
        return { replaced_str }
      end

      -- 定义格式化函数
      local function format_git_heatmap_item(str, colors, strColors)
        local hl_group = {}
        for key, color in pairs(colors) do
          local name = "GitDashboardHightLight" .. key
          vim.api.nvim_set_hl(0, name, color)
          colors[key] = name
        end

        for i, line in ipairs(strColors) do
          local pos = 0

          for j = 1, #line do
            local opos = pos
            pos = pos + getCharLen(str[i], opos + 1)

            local color_name = colors[line:sub(j, j)]
            if color_name then table.insert(hl_group, { color_name, opos, pos }) end
          end
        end

        return str[1], hl_group
      end

      -- 定义格式化函数
      local function format_git_header()
        local git_dashboard_raw = require("git-dashboard-nvim").setup {}
        local git_dashboard = {}
        for _, line in ipairs(git_dashboard_raw) do
          if not whitespace_only(line) then table.insert(git_dashboard, line) end
        end

        local git_repo = git_dashboard[1]
        local git_branch = git_dashboard[#git_dashboard]

        if git_repo == nil and git_branch == nil then
          -- vim.notify("nil")
          return {
            type = "text",
            val = " No git repository",
            opts = { position = "center", hl = "String" },
          }, {
            type = "text",
            val = " ",
            opts = { hl = "Constant", position = "center" },
          }
        end
        -- vim.notify("git_repo: " .. git_repo)
        -- vim.notify("git_branch: " .. git_branch)

        local git_branch_section = {
          type = "text",
          val = " " .. git_repo .. ":" .. string.sub(git_branch, 5, #git_branch),
          opts = { position = "center", hl = "GitSignsChange" },
        }

        local commit_history = {
          type = "group",
          val = {},
        }

        local commit_table = { unpack(git_dashboard, 2, #git_dashboard - 1) }
        for index, line in ipairs(commit_table) do
          if index == 1 then
            table.insert(commit_history.val, {
              type = "text",
              val = line,
              opts = { hl = "Constant", position = "center" },
            })
          else
            local modified_line_str, hl_group =
              format_git_heatmap_item(replace_invisible_chars_in_table(replace_numbers(line)), {
                ["0"] = { fg = "#696c76", ctermfg = 255 }, -- 白色
                ["1"] = { fg = "#c6e48b", ctermfg = 187 }, -- 浅绿色
                ["2"] = { fg = "#7bc96f", ctermfg = 114 }, -- 绿色
                ["3"] = { fg = "#239a3b", ctermfg = 28 }, -- 深绿色
                ["4"] = { fg = "#196127", ctermfg = 22 }, -- 更深绿
                ["5"] = { fg = "#0e4429", ctermfg = 23 }, -- 暗绿色
                ["6"] = { fg = "#003f00", ctermfg = 22 }, -- 深绿色
                ["s"] = { fg = "#11DDDD" }, -- 星期颜色
              }, replace_invisible_chars_in_table(replace_strings(line)))
            -- vim.notify_once("modified_line_str:" .. modified_line_str .. ", hl_group: " .. table_to_string(hl_group))
            table.insert(commit_history.val, {
              type = "text",
              val = modified_line_str,
              opts = { hl = hl_group, position = "center" },
            })
          end
        end

        return git_branch_section, commit_history
      end

      local git_branch_section, commit_history = format_git_header()

      -- write_to_file_in_home(
      --   "nvimLog.txt",
      --   "branch: " .. table_to_string(git_branch_section) .. ",commit_history: " .. table_to_string(commit_history)
      -- )

      local function applyColors(logo, colors, logoColors)
        dashboard.section.header.val = logo
        dashboard.section.header.opts.position = "center"

        for key, color in pairs(colors) do
          local name = "Alpha" .. key
          vim.api.nvim_set_hl(0, name, color)
          colors[key] = name
        end

        dashboard.section.header.opts.hl = {}
        for i, line in ipairs(logoColors) do
          local highlights = {}
          local pos = 0

          for j = 1, #line do
            local opos = pos
            pos = pos + getCharLen(logo[i], opos + 1)

            local color_name = colors[line:sub(j, j)]
            if color_name then table.insert(highlights, { color_name, opos, pos }) end
          end

          table.insert(dashboard.section.header.opts.hl, highlights)
        end
        return dashboard.opts
      end

      require("alpha").setup {
        applyColors({
          [[  ███       ███  ]],
          [[  ████      ████ ]],
          [[  ████     █████ ]],
          [[ █ ████    █████ ]],
          [[ ██ ████   █████ ]],
          [[ ███ ████  █████ ]],
          [[ ████ ████ ████ ]],
          [[ █████  ████████ ]],
          [[ █████   ███████ ]],
          [[ █████    ██████ ]],
          [[ █████     █████ ]],
          [[ ████      ████ ]],
          [[  ███       ███  ]],
          [[                    ]],
          [[  N  E  O  V  I  M  ]],
        }, {
          ["b"] = { fg = "#3399ff", ctermfg = 33 },
          ["a"] = { fg = "#53C670", ctermfg = 35 },
          ["g"] = { fg = "#39ac56", ctermfg = 29 },
          ["h"] = { fg = "#33994d", ctermfg = 23 },
          ["i"] = { fg = "#33994d", bg = "#39ac56", ctermfg = 23, ctermbg = 29 },
          ["j"] = { fg = "#53C670", bg = "#33994d", ctermfg = 35, ctermbg = 23 },
          ["k"] = { fg = "#30A572", ctermfg = 36 },
        }, {
          [[  kkkka       gggg  ]],
          [[  kkkkaa      ggggg ]],
          [[ b kkkaaa     ggggg ]],
          [[ bb kkaaaa    ggggg ]],
          [[ bbb kaaaaa   ggggg ]],
          [[ bbbb aaaaaa  ggggg ]],
          [[ bbbbb aaaaaa igggg ]],
          [[ bbbbb  aaaaaahiggg ]],
          [[ bbbbb   aaaaajhigg ]],
          [[ bbbbb    aaaaajhig ]],
          [[ bbbbb     aaaaajhi ]],
          [[ bbbbb      aaaaajh ]],
          [[  bbbb       aaaaa  ]],
          [[                    ]],
          [[  a  a  a  b  b  b  ]],
        }),
        layout = {
          pad(1),
          dashboard.section.header,
          pad(1),
          commit_history,
          pad(1),
          git_branch_section,
          pad(1),
          dashboard.section.buttons,
          pad(1),
          dashboard.section.footer,
          pad(1),
          startify.section.top_buttons,
          startify.section.mru_cwd,
          startify.section.mru,
          startify.section.bottom_buttons,
        },
      }
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.winbar = nil end,
  },
}

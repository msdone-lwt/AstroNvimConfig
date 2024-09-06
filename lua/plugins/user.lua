-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  --
  -- -- == Examples of Adding Plugins ==
  --
  -- "andweeb/presence.nvim",
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

      local function whitespace_only(str) return str:match "^%s*$" ~= nil end

      local function trim(str) return (string.gsub(str, "^%s*(.-)%s*$", "%1")) end
      function table_to_string(tbl, indent)
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

      local function format_git_heatmap_item(str)
        local hl_group = {}
        local modified_str = ""
        local index = 1

        for char in str:gmatch "." do
          -- FIXME: 图标的 char 为<a0>、<c2> <9d>、<94>、<ef>
          if char:match "%d" then
            local a = tonumber(char)

            if a == 1 then
              table.insert(hl_group, { "GitDashboardContributionLevel1", index - 1, index })
            elseif a == 2 then
              table.insert(hl_group, { "GitDashboardContributionLevel2", index - 1, index })
            elseif a == 3 then
              table.insert(hl_group, { "GitDashboardContributionLevel3", index - 1, index })
            elseif a == 4 then
              table.insert(hl_group, { "GitDashboardContributionLevel4", index - 1, index })
            elseif a == 5 then
              table.insert(hl_group, { "GitDashboardContributionLevel5", index - 1, index })
            elseif a == 6 then
              table.insert(hl_group, { "GitDashboardContributionLevel6", index - 1, index })
            end

            modified_str = modified_str .. ""
            -- modified_str = modified_str .. "*"
          elseif char:match "%a" then
            table.insert(hl_group, { "String", index - 1, index })
            modified_str = modified_str .. char
          else
            table.insert(hl_group, { "GitDashboardContributionLevel0", index - 1, index })
            modified_str = modified_str .. char
          end

          index = index + 1
        end

        -- vim.notify_once(modified_str .. " ====》 hl_group" .. table_to_string(hl_group))
        return modified_str, hl_group
      end

      local function format_git_header()
        local git_dashboard_raw = require("git-dashboard-nvim").setup {}
        local git_dashboard = {}
        for _, line in ipairs(git_dashboard_raw) do
          if not whitespace_only(line) then table.insert(git_dashboard, line) end
        end

        local git_repo = git_dashboard[1]
        local git_branch = git_dashboard[#git_dashboard]

        if git_repo == nil and git_branch == nil then
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
            local modified_line_str, hl_group = format_git_heatmap_item(line)
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

      -- helper function for utf8 chars
      local function getCharLen(s, pos)
        local byte = string.byte(s, pos)
        if not byte then return nil end
        return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
      end

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
}

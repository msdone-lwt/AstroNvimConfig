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

      local function pad(n) return { type = "padding", val = n } end

      local function whitespace_only(str) return str:match "^%s*$" ~= nil end

      local function format_git_header()
        local git_dashboard_raw = require("git-dashboard-nvim").setup {}
        local git_dashboard = {}
        for _, line in ipairs(git_dashboard_raw) do
          if not whitespace_only(line) then table.insert(git_dashboard, line) end
        end

        local git_repo = git_dashboard[1]
        local git_branch = git_dashboard[#git_dashboard]
        -- for i = 2, #git_dashboard - 1 do
        --   local line = git_dashboard[i]
        --   commit_data = commit_data .. "\n" .. string.rep(" ", 3) .. line
        -- end

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
        for _, line in ipairs(commit_table) do
          table.insert(commit_history.val, {
            type = "text",
            val = string.rep(" ", 3) .. line,
            opts = { hl = "Comment", position = "center" },
          })
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
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "🚀 Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"

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
          [[  a  b  g  k  h  a  ]],
        }),
        layout = {
          pad(2),
          dashboard.section.header,
          pad(1),
          commit_history,
          pad(1),
          git_branch_section,
          pad(1),
          dashboard.section.buttons,
          pad(1),
          dashboard.section.footer,
        },
      }
    end,
  },
}

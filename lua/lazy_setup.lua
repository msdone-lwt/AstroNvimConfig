require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4", -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  { import = "community" },
  { import = "plugins" },
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup {
        focus = false,
      }
    end,
  },
  -- NOTE: Falsh
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      jump = {
        autojump = true,
      },
      label = {
        uppercase = true,
        before = true,
        after = false,
        rainbow = {
          enabled = true,
          -- number between 1 and 9
          shade = 9,
        },
      },
      modes = {
        char = {
          keys = { "f", "F", "t", "T" },
          jump_labels = true,
          jump = {
            autojump = true,
          },
        },
        treesitter = {
          jump = { pos = "range", autojump = true },
          label = { style = "overlay" },
        },
      },
    },
    keys = {
      -- NOTE: mode:
      -- c : 搜索模式, [/,?] 触发
      { "<leader><leader>w", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      {
        "<leader><leader>W",
        mode = { "n", "x", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search",
      },
      { "<leader><leader>w", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "astrodark", "habamax" } },
  ui = { backdrop = 70 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])

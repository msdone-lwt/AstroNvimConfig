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
  -- NOTE: code_runner.nvim
  -- {
  --   "CRAG666/code_runner.nvim",
  --   config = function()
  --     require("code_runner").setup {
  --       focus = false,
  --     }
  --   end,
  -- },
  -- NOTE: falsh.nvim
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   ---@type Flash.Config
  --   opts = {
  --     jump = {
  --       autojump = true,
  --     },
  --     label = {
  --       uppercase = true,
  --       before = true,
  --       after = false,
  --       rainbow = {
  --         enabled = true,
  --         -- number between 1 and 9
  --         shade = 9,
  --       },
  --     },
  --     modes = {
  --       char = {
  --         keys = { "f", "F", "t", "T" },
  --         jump_labels = true,
  --         jump = {
  --           autojump = true,
  --         },
  --       },
  --       treesitter = {
  --         jump = { pos = "range", autojump = true },
  --         label = { style = "overlay" },
  --       },
  --     },
  --  },
  -- },
  -- NOTE: nvim-surround
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   event = "VeryLazy",
  --   config = function()
  --     require("nvim-surround").setup {
  --       -- Configuration here, or leave empty to use defaults
  --     }
  --   end,
  -- },
  -- NOTE: overseer
  -- {
  --   "stevearc/overseer.nvim",
  --   opts = {},
  -- },
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

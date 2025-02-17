return {
  { "craftzdog/solarized-osaka.nvim", lazy = true, opts = {
    transparent = true,
  } },
  { "sainnhe/everforest", lazy = true },
  { "Mofiqul/dracula.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        transparent_background = true, -- disables setting the background color.
      }
    end,
  },
}

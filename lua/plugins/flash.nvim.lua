-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Flash

-- @type LazySpec

return {
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
}

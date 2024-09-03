-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize git-dashboard-nvim

-- @type LazySpec

return {
  {
    "juansalvatore/git-dashboard-nvim",
    event = "VeryLazy",
    config = function()
      require("git-dashboard-nvim").setup {
        filled_squares = { "", "", "", "", "", "" },
      }
    end,
  },
}

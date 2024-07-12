-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize code_runner.nvim

-- @type LazySpec

return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup {
      focus = false,
    }
  end,
}

-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize hlchunk.nvim

-- @type LazySpec

return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup {
      chunk = {
        enable = true,
        -- ...
      },
      indent = {
        enable = true,
        -- ...
      },
      blank = {
        enable = true,
        -- ...
      },
      line_num = {
        enable = true,
        -- ...
      },
    }
  end,
}

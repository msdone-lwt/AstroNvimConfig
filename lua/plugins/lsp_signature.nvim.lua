-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize lsp_signature.nvim

-- @type LazySpec
-- 
return {
  "ray-x/lsp_signature.nvim",
  event = "BufRead",
  config = function() require("lsp_signature").setup() end,
}

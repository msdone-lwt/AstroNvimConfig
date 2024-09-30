-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

-- NOTE: 20240902 activate this file
-- font: Monaco Nerd Font

-- vim.cmd [[ highlight Cursor guifg=red guibg=yellow blend=100 ]]
vim.g.have_nerd_font = true
vim.g.copilot_workspace_folders = vim.fn.expand "%:p:h"

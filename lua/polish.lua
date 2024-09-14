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

-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel0", { fg = "#696c76", ctermfg = 255 }) -- 白色
-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel1", { fg = "#c6e48b", ctermfg = 187 }) -- 浅绿色
-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel2", { fg = "#7bc96f", ctermfg = 114 }) -- 绿色
-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel3", { fg = "#239a3b", ctermfg = 28 })  -- 深绿色
-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel4", { fg = "#196127", ctermfg = 22 })  -- 更深绿色
-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel5", { fg = "#0e4429", ctermfg = 23 })  -- 暗绿色
-- vim.api.nvim_set_hl(0, "GitDashboardContributionLevel6", { fg = "#003f00", ctermfg = 22 })  -- 深绿色

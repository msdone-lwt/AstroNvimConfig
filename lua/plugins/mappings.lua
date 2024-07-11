-- NOTE: mode
-- Normal 模式 (n): 正常模式，通常是你在编辑器中进行大部分操作的模式。
-- Visual 模式 (v): 可视模式，用于选择文本块。
-- Visual 模式 (x): 这里的 x 是 v 的一种变体，表示可视模式的字符选择。
-- Select 模式 (s): 选择模式，类似于可视模式，但用于替换选择的文本。
-- Operator-pending 模式 (o): 操作符等待模式，用于等待下一个操作符命令。
-- Insert 模式 (i): 插入模式，用于插入文本。
-- Command-line 模式 (c): 命令行模式，用于输入命令。
-- Terminal 模式 (t): 终端模式，用于在嵌入的终端中操作。
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<enter>"] = { ":silent .w !xargs -0r tmux send -t 1 -l <cr>", desc = "Tmux sends command to pane 1" },
          ["<leader>s"] = { "/<C-r>*<CR>", desc = "Search the contents of register *" },
          ["<leader>r"] = { ":RunCode<CR>", desc = "code-runner.nvim - RunCode" },
          ["<leader>L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["<leader>H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          ["L"] = { "$" },
          ["H"] = { "^" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command         -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
        v = {
          ["p"] = { "pgvy", desc = "paste" },
          ["L"] = { "$" },
          ["H"] = { "^" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}

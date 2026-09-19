return {
  "sphamba/smear-cursor.nvim",

  -- vvv 添加这一行 vvv
  cond = vim.g.neovide == nil, -- 关键！仅在非 Neovide 环境下加载
  -- ^^^ 添加这一行 ^^^

  opts = {},
}
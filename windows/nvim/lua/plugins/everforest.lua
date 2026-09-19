return {
  "neanias/everforest-nvim",
  lazy = false,
  priority = 1000,
  opts = {
    -- 1. 保持背景透明 (你之前的设置)
    transparent_background = true,

    -- 2. 设置对比度 (hard/medium/soft)
    -- 注意：这里只决定对比度，不决定是亮还是暗。
    -- Everforest 会自动根据 vim.o.background (light/dark) 来决定用 "明亮的hard" 还是 "暗黑的hard"
    background = "medium",

    -- 3. 其他设置
    disable_italic_comments = true,
  },
  config = function(_, opts)
    -- 【重点】这里千万不要写 vim.o.background = "dark"
    -- 把控制权完全交给下面的自动切换插件
    require("everforest").setup(opts)
  end,
}
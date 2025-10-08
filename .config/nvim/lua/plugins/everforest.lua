return {
  "neanias/everforest-nvim",
  -- version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  opts = {
    -- 这是 Everforest 文档里定义的透明选项
    transparent_background = true,
    -- 你还可以顺便配置其他 Everforest 的专属选项
    background = "hard", -- 'soft', 'medium', 'hard'
    --取消注释斜体
    disable_italic_comments = true,
  },
  config = function(_, opts)
    vim.o.background = "dark" -- 'dark', 'light'
    require("everforest").setup(opts)
  end,
}

return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    -- 检查间隔：3000毫秒 (3秒)
    -- 在 WSL 里调用 Windows 命令有开销，不要设置得太频繁（比如 1000ms），3秒是个比较舒服的平衡点
    update_interval = 3000,

    -- 当检测到 Windows 是【暗色】时执行：
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark") -- 告诉 Neovim 现在是暗色
      vim.cmd("colorscheme everforest")             -- 重载 Everforest 主题以应用新颜色
    end,

    -- 当检测到 Windows 是【亮色】时执行：
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light") -- 告诉 Neovim 现在是亮色
      vim.cmd("colorscheme everforest")              -- 重载 Everforest 主题
    end,
  },
}
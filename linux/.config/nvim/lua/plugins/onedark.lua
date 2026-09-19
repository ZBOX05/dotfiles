return {
  "navarasu/onedark.nvim",
  priority = 1000, -- 确保优先加载
  lazy = true,
  opts = {
    -- 主题风格: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
    style = "warm",

    -- 透明背景
    transparent = false,

    -- Lualine状态栏透明
    lualine = {
      transparent = true,
    },

    -- 代码样式
    code_style = {
      comments = "none",
      keywords = "bold", -- 'italic', 'bold', 'underline', 'none'
      functions = "none",
      strings = "none",
      variables = "none",
    },

    -- 自定义颜色 (在这里覆盖或添加颜色)
    colors = {
      -- green = '#00ffaa',
    },

    -- 自定义高亮 (在这里覆盖语法高亮)
    highlights = {
      -- ["@lsp.type.keyword"] = { fg = "$green" },
    },
    -----------------------------------------------------------------------------
    -- 以下为不常用的高级选项，默认即可

    -- 更改终端颜色以匹配主题
    term_colors = true,
    -- 在文件末尾显示波浪线
    ending_tildes = false,
    -- 反转 cmp 菜单中的 item kind 高亮
    cmp_itemkind_reverse = false,

    -- 切换主题风格的快捷键，设置为 nil 则禁用
    toggle_style_key = nil, -- 例如: "<leader>ts"
    -- 切换的主题列表
    toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },

    -- LSP诊断信息样式
    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  },
}

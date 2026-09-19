return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",

      -- Tab 逻辑：
      -- 1. 优先跳转代码片段占位符 (snippet_forward)
      -- 2. 其次接受当前补全 (accept)
      -- 3. 最后回退到缩进 (fallback)
      ['<Tab>'] = { 'snippet_forward', 'accept', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      -- 上下选择逻辑 (采用更强的 show 逻辑，确保菜单是可见的)
      -- 逻辑：尝试显示菜单 -> 选择上一个 -> 回退
      ['<C-k>'] = { 'show', 'select_prev', 'fallback' },
      ['<Up>']  = { 'show', 'select_prev', 'fallback' },

      -- 逻辑：尝试显示菜单 -> 选择下一个 -> 回退
      ['<C-j>'] = { 'show', 'select_next', 'fallback' },
      ['<Down>'] = { 'show', 'select_next', 'fallback' },
    },

    completion = {
      menu = { auto_show = true },
      ghost_text = { enabled = true },
    },
  },
}
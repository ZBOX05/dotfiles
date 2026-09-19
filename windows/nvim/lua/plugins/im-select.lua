return {
  "keaising/im-select.nvim",
  cond = not vim.g.vscode,
  config = function()
    require("im_select").setup({
      -- 1. 核心命令
      default_command = "im-select.exe",

      -- 2. 告诉插件：Normal 模式下强制用系统英文 (1033)
      -- 只有这样才能保证 Vim 的快捷键（如 : / ? 等）绝对不被输入法吞掉
      default_im_select = "1033",

      -- 3. 自动切换逻辑
      set_default_events = { "InsertLeave", "CmdlineLeave" },
      set_previous_events = { "InsertEnter" },

      -- 4. 异步防卡顿
      async_switch_im = true,
    })

    -- ============================================================
    -- 你的点睛之笔：退出时交还给小狼毫 (2052)
    -- ============================================================
    vim.api.nvim_create_autocmd("VimLeave", {
      callback = function()
        -- 退出时切回小狼毫，依靠小狼毫在终端里的“英文模式记忆”
        -- 这样既不用改系统语言列表，也能无缝敲命令
        vim.fn.jobstart({ "im-select.exe", "2052" }, { detach = true })
      end,
    })
  end,
}
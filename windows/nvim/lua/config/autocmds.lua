-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- 文件路径: ~/.config/nvim/lua/config/autocmds.lua
local filetype_settings_group = vim.api.nvim_create_augroup("ZBOXCustomFiletypeSettings", { clear = true })

-- VSCode 专用：防闪屏输入法切换
if vim.g.vscode then
  -- 定义切换函数
  local function switch_im(code)
    -- 【关键修改】：使用 {命令, 参数} 的列表格式
    -- 这会绕过 Shell 直接执行程序，从而彻底消除黑框闪屏
    local cmd_list = { "im-select.exe", code }

    -- 异步执行，detach=true 保证不会阻塞编辑器
    vim.fn.jobstart(cmd_list, { detach = true })
  end

  -- 退出插入模式 -> 切回英文 (1033)
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      switch_im("1033")
    end,
  })

  -- 进入插入模式 -> 切回中文 (2052)
  -- 如果你不想自动切中文，可以注释掉下面这段
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      switch_im("2052")
    end,
  })
end
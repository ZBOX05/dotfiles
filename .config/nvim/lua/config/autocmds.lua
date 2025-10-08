-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- 文件路径: ~/.config/nvim/lua/config/autocmds.lua
local filetype_settings_group = vim.api.nvim_create_augroup("MyCustomFiletypeSettings", { clear = true })

-- 规则：为 C, C++, Verilog 设置4格缩进
vim.api.nvim_create_autocmd("FileType", {
  group = filetype_settings_group,
  pattern = { "c", "cpp", "verilog", "make" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.tabstop = 4
  end,
})

-- 注意：我们没有在这里设置全局的默认值。
-- 其他未匹配到的文件类型，将继续使用 LazyVim 的默认2格缩进。

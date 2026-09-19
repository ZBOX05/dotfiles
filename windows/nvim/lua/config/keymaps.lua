-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 1. 让 ; 变成 : (进入命令模式，这很高频)
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Enter Command Mode" })

-- 2. 让 : 变成 ; (重复上一次 f/t 查找，偶尔用)
-- 注意：这里原本的 : 需要按 Shift+; 才能触发，现在你按 Shift+; 就是重复查找
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Repeat f/t search" })
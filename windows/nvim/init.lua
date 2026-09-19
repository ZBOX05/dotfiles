-- bootstrap lazy.nvim, LazyVim and your plugins
vim.opt.colorcolumn = '80,100' -- 在 80 和 100 列画线
require("config.lazy")
require("config.autocmds")

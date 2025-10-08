return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        height = 8,
      },
    },
    picker = {
      --hidden = true,
      sources = {
        explorer = {
          --auto_close = false,
          layout = {
            layout = {
              width = 20,
            },
          },
        },
      },
    },
  },
}

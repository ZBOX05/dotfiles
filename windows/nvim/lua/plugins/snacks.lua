return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        -- Used by the `header` section
        --         header = [[
        -- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        -- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        -- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        -- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        -- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        -- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        --       },
        header = [[
███████╗██████╗  ██████╗ ██╗  ██╗██╗   ██╗██╗███╗   ███╗
╚══███╔╝██╔══██╗██╔═══██╗╚██╗██╔╝██║   ██║██║████╗ ████║
  ███╔╝ ██████╔╝██║   ██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
 ███╔╝  ██╔══██╗██║   ██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗██████╔╝╚██████╔╝██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      -- item field formatters
      -- sections = {
      --   { section = "header" },
      --   { section = "keys", gap = 1, padding = 1 },
      --   { section = "startup" },
      -- },
      -- sections = {
      --   { section = "header" },
      --   { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      --   { section = "startup" },
      -- },
      -- sections = {
      --   { section = "header" },
      --   { section = "keys", gap = 1 },
      --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
      --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
      --   { section = "startup" },
      -- },
      sections = {
        { section = "header" },
        -- {
        --   pane = 2,
        --   section = "terminal",
        --   cmd = "colorscript -e square",
        --   height = 5,
        --   padding = 1,
        -- },
        -- { section = "keys", gap = 1, padding = 1 },
        -- { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2 },
        -- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2 },
        -- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2 },
        -- {
        --   pane = 2,
        --   icon = " ",
        --   title = "Git Status",
        --   section = "terminal",
        --   enabled = function()
        --     return Snacks.git.get_root() ~= nil
        --   end,
        --   cmd = "git status --short --branch --renames",
        --   height = 5,
        --   padding = 1,
        --   ttl = 5 * 60,
        --   indent = 3,
        -- },
        { section = "startup" },
      },
    },
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

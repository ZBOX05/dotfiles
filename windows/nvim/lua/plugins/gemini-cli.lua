return {
  "jonroosevelt/gemini-cli.nvim",
  lazy = true,
  config = function()
    require("gemini").setup({
      split_direction = "vertical", -- optional: "vertical" (default) or "horizontal"
    })
  end,
}

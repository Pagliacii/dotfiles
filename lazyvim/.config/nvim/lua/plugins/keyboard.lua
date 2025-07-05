return {
  {
    "folke/which-key.nvim",
    event = "LazyFile",
    opts = {
      preset = "modern",
      icons = {
        rules = {
          { plugin = "hydrate.nvim", icon = "󰆫 ", color = "azure" },
          { plugin = "dropbar.nvim", icon = "󰳯 ", color = "orange" },
          { plugin = "readermode.nvim", icon = "󱃀 ", color = "green" },
          { plugin = "legendary.nvim", icon = "⚡ ", color = "red" },
        },
      },
    },
  },

  {
    "max397574/better-escape.nvim",
    config = true,
    keys = {
      { "jj", mode = "i" },
      { "jk", mode = "i" },
    },
  },
}

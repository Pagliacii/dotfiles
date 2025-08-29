return {
  {
    "folke/which-key.nvim",
    event = "LazyFile",
    opts = {
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

  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "bottom-center",
    },
    keys = {
      { "<leader>K", "<cmd>ShowkeysToggle<cr>", desc = "Toggle showkeys", noremap = true, silent = true },
    },
  },
}

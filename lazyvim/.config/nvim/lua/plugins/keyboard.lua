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
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    version = "*",
    config = true,
    keys = {
      { "<leader>Ks", "<cmd>Screenkey<cr>", desc = "Toggle Screenkey" },
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
    "jokajak/keyseer.nvim",
    version = false,
    config = true,
    cmd = { "KeySeer" },
    keys = {
      { "<leader>Kb", "<cmd>KeySeer<cr>", desc = "Toggle KeySeer" },
    },
  },

  {
    "tris203/hawtkeys.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
    keys = {
      { "<leader>Kk", "<cmd>Hawtkeys<cr>", desc = "Searching New Keymaps", noremap = true, silent = true },
      { "<leader>Ka", "<cmd>HawtkeysAll<cr>", desc = "Show All Existing Keymaps", noremap = true, silent = true },
      { "<leader>Kd", "<cmd>HawtkeysDupes<cr>", desc = "Showing Duplicate Keymaps", noremap = true, silent = true },
    },
  },

  {
    "meznaric/key-analyzer.nvim",
    opts = {},
    cmd = "KeyAnalyzer",
  },
}

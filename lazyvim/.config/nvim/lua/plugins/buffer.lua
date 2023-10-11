return {
  {
    "axkirillov/hbac.nvim",
    dependencies = {
      -- these are optional, add them, if you want the telescope module
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Hbac",
    opts = {
      threshold = 8,
    },
    keys = {
      { "<leader>[", "<cmd>Hbac telescope<cr>", desc = "Manage buffers" },
    },
  },
}

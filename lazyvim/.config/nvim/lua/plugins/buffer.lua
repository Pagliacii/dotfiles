return {
  {
    "axkirillov/hbac.nvim",
    dependencies = {
      -- these are optional, add them, if you want the telescope module
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
      require("hbac").setup(opts)
      require("telescope").load_extension("hbac")
    end,
    cmd = "Hbac",
    opts = {
      threshold = 8,
    },
    keys = {
      { "<leader>tb", "<cmd>Telescope hbac buffers<cr>", desc = "Manage buffers" },
    },
  },
}

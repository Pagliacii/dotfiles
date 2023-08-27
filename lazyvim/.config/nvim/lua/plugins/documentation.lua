return {
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsOpenCurrent",
      "DevdocsOpenCurrentFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
    keys = {
      { "<leader>Di", "<cmd>DevdocsInstall<cr>", desc = "Install docs" },
      { "<leader>Du", "<cmd>DevdocsUninstall<cr>", desc = "Uninstall docs" },
      { "<leader>Do", "<cmd>DevdocsOpenCurrentFloat<cr>", desc = "Open docs (current)" },
      { "<leader>DO", "<cmd>DevdocsOpenFloat<cr>", desc = "Open docs (all)" },
      { "<leader>DU", "<cmd>DevdocsUpdate<cr>", desc = "Update docs" },
    },
  },
}

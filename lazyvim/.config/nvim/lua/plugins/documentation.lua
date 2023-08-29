return {
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      previewer_cmd = "glow",
      cmd_args = { "-s", "dark", "-w", "80" },
      picker_cmd = true,
    },
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
      { "<leader>Di", "<cmd>DevdocsInstall<cr>", desc = "Install docs", noremap = true, silent = true },
      { "<leader>Du", "<cmd>DevdocsUninstall<cr>", desc = "Uninstall docs", noremap = true, silent = true },
      {
        "<leader>Do",
        "<cmd>DevdocsOpenCurrentFloat<cr>",
        desc = "Open docs (current)",
        noremap = true,
        silent = true,
      },
      { "<leader>DO", "<cmd>DevdocsOpenFloat<cr>", desc = "Open docs (all)", noremap = true, silent = true },
      { "<leader>DU", "<cmd>DevdocsUpdate<cr>", desc = "Update docs", noremap = true, silent = true },
      { "<leader>DF", "<cmd>DevdocsFetch<cr>", desc = "Fetch metadata", noremap = true, silent = true },
    },
  },
}
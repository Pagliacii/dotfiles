return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd> DiffviewOpen<cr>", desc = "Open Diffview" },
    },
  },

  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    cmd = { "Octo" },
  },

  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = true,
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
      { "sindrets/diffview.nvim" },
    },
    cmd = { "AdvancedGitSearch" },
    keys = {
      { "<leader>ga", "<cmd>AdvancedGitSearch<cr>", desc = "Advanced search", noremap = true },
      {
        "<leader>gd",
        "<cmd>lua require('telescope').extensions.advanced_git_search.diff_commit_line()<cr>",
        mode = "v",
        desc = "Diff lines",
        noremap = true,
      },
    },
  },
}

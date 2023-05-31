return {
  {
    "Pagliacii/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    opts = function(_, opts)
      local actions = require("diffview.actions")
      opts.keymaps = {
        view = {
          { "n", "q",          "<cmd>DiffviewClose<cr>" },
          { "n", "<leader>gR", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh Diffview" } },
          { "n", "<leader>gB", actions.toggle_files,       { desc = "Toggle the file panel" } },
          { "n", "<leader>b",  false },
        },
        file_panel = {
          { "n", "q",          "<cmd>DiffviewClose<cr>" },
          { "n", "<leader>gR", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh Diffview" } },
        },
        file_history_panel = {
          { "n", "q",          "<cmd>DiffviewClose<cr>" },
          { "n", "<leader>gR", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh Diffview" } },
        },
      }
      opts.hooks = {
        diff_buf_read = function(bufnr)
          vim.diagnostic.disable(bufnr)
        end,
      }
      return opts
    end,
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen -uno<cr>", desc = "Open Diffview",  noremap = true },
      { "<leader>gC", "<cmd>DiffviewClose<cr>",     desc = "Close Diffview", noremap = true },
      {
        "<leader>gF",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Current file history",
        noremap = true,
      },
      {
        "<leader>gF",
        "<cmd>DiffviewFileHistory<cr>",
        mode = "v",
        desc = "File history",
        noremap = true,
      },
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
      { "Pagliacii/diffview.nvim" },
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

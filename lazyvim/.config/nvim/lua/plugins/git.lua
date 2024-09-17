return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    opts = function(_, opts)
      local actions = require("diffview.actions")
      opts.keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>" },
          { "n", "<leader>gR", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh Diffview" } },
          { "n", "<leader>gB", actions.toggle_files, { desc = "Toggle the file panel" } },
          { "n", "<leader>b", false },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>" },
          { "n", "<leader>gR", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh Diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>" },
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
      { "<leader>gD", "<cmd>DiffviewOpen -uno<cr>", desc = "Open Diffview", noremap = true },
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
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours", noremap = true },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs", noremap = true },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both", noremap = true },
      { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none", noremap = true },
      { "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict", noremap = true },
      { "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous conflict", noremap = true },
      { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "List conflicts", noremap = true },
    },
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
      { "tpope/vim-fugitive" },
      { "sindrets/diffview.nvim" },
    },
    config = function()
      require("telescope").load_extension("advanced_git_search")
    end,
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

  {
    "f-person/git-blame.nvim",
    cmd = {
      "GitBlameToggle",
      "GitBlameCopySHA",
      "GitBlameCopyCommitURL",
      "GitBlameOpenCommitURL",
      "GitBlameCopyFileURL",
      "GitBlameOpenFileURL",
    },
    opts = {
      display_virtual_text = false,
    },
  },

  {
    "niuiic/git-log.nvim",
    dependencies = { "niuiic/core.nvim" },
    keys = {
      {
        "<leader>gl",
        [[:lua require("git-log").check_log()<cr>]],
        mode = { "n", "v" },
        desc = "Log of selected",
        silent = true,
      },
    },
  },

  {
    "fredeeb/tardis.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    cmd = { "Tardis" },
    keys = {
      { "<leader>gt", "<cmd>Tardis git<cr>", desc = "Tardis", noremap = true },
    },
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      { "nvim-lua/plenary.nvim" }, -- required
      { "sindrets/diffview.nvim" }, -- optional -- Diff integration
      { "nvim-telescope/telescope.nvim" }, -- optional
    },
    cmd = { "Neogit" },
    opts = {
      -- "ascii"   is the graph the git CLI generates
      -- "unicode" is the graph like https://github.com/rbong/vim-flog
      graph_sytle = "unicode",
      -- Change the default way of opening neogit
      kind = "tab",
    },
    keys = {
      { "<leader>gns", "<cmd>Neogit<cr>", desc = "Status", noremap = true },
      { "<leader>gno", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Open", noremap = true },
      { "<leader>gnb", "<cmd>Neogit branch<cr>", desc = "Branch", noremap = true },
      { "<leader>gnc", "<cmd>Neogit commit<cr>", desc = "Commit", noremap = true },
      { "<leader>gnC", "<cmd>Neogit cherry_pick<cr>", desc = "Cherry-pick", noremap = true },
      { "<leader>gnd", "<cmd>Neogit diff<cr>", desc = "Diff", noremap = true },
      { "<leader>gnf", "<cmd>Neogit fetch<cr>", desc = "Fetch", noremap = true },
      { "<leader>gni", "<cmd>Neogit ignore<cr>", desc = "Ignore", noremap = true },
      { "<leader>gnl", "<cmd>Neogit log<cr>", desc = "Log", noremap = true },
      { "<leader>gnm", "<cmd>Neogit merge<cr>", desc = "Merge", noremap = true },
      { "<leader>gnp", "<cmd>Neogit pull<cr>", desc = "Pull", noremap = true },
      { "<leader>gnP", "<cmd>Neogit push<cr>", desc = "Push", noremap = true },
      { "<leader>gnr", "<cmd>Neogit remote<cr>", desc = "Remote", noremap = true },
      { "<leader>gnR", "<cmd>Neogit rebase<cr>", desc = "Rebase", noremap = true },
      { "<leader>gnS", "<cmd>Neogit stash<cr>", desc = "Stash", noremap = true },
      { "<leader>gnt", "<cmd>Neogit tag<cr>", desc = "Tag", noremap = true },
      { "<leader>gnT", "<cmd>Neogit reset<cr>", desc = "Reset", noremap = true },
      { "<leader>gnv", "<cmd>Neogit revert<cr>", desc = "Revert", noremap = true },
      { "<leader>gnw", "<cmd>Neogit worktree<cr>", desc = "Worktree", noremap = true },
    },
  },
}

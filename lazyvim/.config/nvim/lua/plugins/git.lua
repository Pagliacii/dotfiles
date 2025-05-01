return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    opts = function(_, opts)
      opts.keymaps = {
        disable_defaults = false, -- Disable the default keymaps
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>" },
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
          vim.diagnostic.enable(false, { bufnr = bufnr })
        end,
      }
      opts.view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
          disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
      }
      return opts
    end,
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen -uno<cr>", desc = "Open Diffview", noremap = true },
      {
        "<leader>gdf",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Current file history",
        noremap = true,
      },
      {
        "<leader>gdf",
        "<cmd>'<,'>DiffviewFileHistory<cr>",
        mode = { "v", "x" },
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
    cmd = "Octo",
    event = {
      { event = "BufReadCmd", pattern = "octo://*" },
    },
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "telescope",
      mappings_disable_default = true,
      mappings = {
        issue = {
          close_issue = { lhs = "<leader>Oic", desc = "close issue" },
          reopen_issue = { lhs = "<leader>Oio", desc = "reopen issue" },
          list_issues = { lhs = "<leader>Oil", desc = "list open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "reload issue" },
          open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
          copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
          add_assignee = { lhs = "<leader>Oaa", desc = "add assignee" },
          remove_assignee = { lhs = "<leader>Oad", desc = "remove assignee" },
          create_label = { lhs = "<leader>Olc", desc = "create label" },
          add_label = { lhs = "<leader>Ola", desc = "add label" },
          remove_label = { lhs = "<leader>Old", desc = "remove label" },
          goto_issue = { lhs = "<leader>Oig", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<leader>Oca", desc = "add comment" },
          delete_comment = { lhs = "<leader>Ocd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          react_hooray = { lhs = "<leader>Orp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<leader>Orh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<leader>Ore", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<leader>Or+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<leader>Or-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<leader>Orr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<leader>Orl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<leader>Orc", desc = "add/remove 😕 reaction" },
        },
        pull_request = {
          checkout_pr = { lhs = "<leader>Opo", desc = "checkout PR" },
          merge_pr = { lhs = "<leader>Opm", desc = "merge commit PR" },
          squash_and_merge_pr = { lhs = "<leader>Opsm", desc = "squash and merge PR" },
          rebase_and_merge_pr = { lhs = "<leader>Oprm", desc = "rebase and merge PR" },
          list_commits = { lhs = "<leader>Opc", desc = "list PR commits" },
          list_changed_files = { lhs = "<leader>Opf", desc = "list PR changed files" },
          show_pr_diff = { lhs = "<leader>Opd", desc = "show PR diff" },
          add_reviewer = { lhs = "<leader>Ova", desc = "add reviewer" },
          remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer request" },
          close_issue = { lhs = "<leader>Oic", desc = "close PR" },
          reopen_issue = { lhs = "<leader>Oio", desc = "reopen PR" },
          list_issues = { lhs = "<leader>Oil", desc = "list open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "reload PR" },
          open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
          copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
          goto_file = { lhs = "gf", desc = "go to file" },
          add_assignee = { lhs = "<leader>Oaa", desc = "add assignee" },
          remove_assignee = { lhs = "<leader>Oad", desc = "remove assignee" },
          create_label = { lhs = "<leader>Olc", desc = "create label" },
          add_label = { lhs = "<leader>Ola", desc = "add label" },
          remove_label = { lhs = "<leader>Old", desc = "remove label" },
          goto_issue = { lhs = "<leader>Oig", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<leader>Oca", desc = "add comment" },
          delete_comment = { lhs = "<leader>Ocd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          react_hooray = { lhs = "<leader>Orp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<leader>Orh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<leader>Ore", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<leader>Or+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<leader>Or-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<leader>Orr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<leader>Orl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<leader>Orc", desc = "add/remove 😕 reaction" },
          review_start = { lhs = "<leader>Ovs", desc = "start a review for the current PR" },
          review_resume = { lhs = "<leader>Ovr", desc = "resume a pending review for the current PR" },
        },
        review_thread = {
          goto_issue = { lhs = "<leader>Oig", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<leader>Oca", desc = "add comment" },
          add_suggestion = { lhs = "<leader>Osa", desc = "add suggestion" },
          delete_comment = { lhs = "<leader>Ocd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          select_next_entry = { lhs = "]q", desc = "move to next changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
          select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
          select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          react_hooray = { lhs = "<leader>Orp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<leader>Orh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<leader>Ore", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<leader>Or+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<leader>Or-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<leader>Orr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<leader>Orl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<leader>Orc", desc = "add/remove 😕 reaction" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "approve review" },
          comment_review = { lhs = "<C-m>", desc = "comment review" },
          request_changes = { lhs = "<C-r>", desc = "request changes review" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        },
        review_diff = {
          submit_review = { lhs = "<leader>Ovs", desc = "submit review" },
          discard_review = { lhs = "<leader>Ovd", desc = "discard review" },
          add_review_comment = { lhs = "<leader>Oca", desc = "add a new review comment" },
          add_review_suggestion = { lhs = "<leader>Osa", desc = "add a new review suggestion" },
          focus_files = { lhs = "<leader>Oe", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>Ob", desc = "hide/show changed files panel" },
          next_thread = { lhs = "]t", desc = "move to next thread" },
          prev_thread = { lhs = "[t", desc = "move to previous thread" },
          select_next_entry = { lhs = "]q", desc = "move to next changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
          select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
          select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader>O<space>", desc = "toggle viewer viewed state" },
          goto_file = { lhs = "gf", desc = "go to file" },
        },
        file_panel = {
          submit_review = { lhs = "<leader>Ovs", desc = "submit review" },
          discard_review = { lhs = "<leader>Ovd", desc = "discard review" },
          next_entry = { lhs = "j", desc = "move to next changed file" },
          prev_entry = { lhs = "k", desc = "move to previous changed file" },
          select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
          refresh_files = { lhs = "R", desc = "refresh changed files panel" },
          focus_files = { lhs = "<leader>Oe", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>Ob", desc = "hide/show changed files panel" },
          select_next_entry = { lhs = "]q", desc = "move to next changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
          select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
          select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader>O<space>", desc = "toggle viewer viewed state" },
        },
      },
    },
    keys = {
      { "<leader>Oi", "<cmd>Octo issue list<CR>", desc = "List Issues (Octo)" },
      { "<leader>OI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
      { "<leader>Op", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<leader>OP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<leader>Or", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<leader>OS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<leader>Oa", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<leader>Oc", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<leader>Ol", "", desc = "+label (Octo)", ft = "octo" },
      { "<leader>Oi", "", desc = "+issue (Octo)", ft = "octo" },
      { "<leader>Or", "", desc = "+react (Octo)", ft = "octo" },
      { "<leader>Op", "", desc = "+pr (Octo)", ft = "octo" },
      { "<leader>Ov", "", desc = "+review (Octo)", ft = "octo" },

      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
    },
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

  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = true,
    keys = {
      {
        "<leader>gy",
        proxy = "<leader>gy",
        mode = { "n", "v" },
        desc = "Generate shareable file permalinks",
        noremap = true,
      },
    },
  },
}

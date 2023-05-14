return {
  {
    "sindrets/winshift.nvim",
    keys = {
      { "<leader>wm", "<cmd>WinShift<cr>",       desc = "Start Win-Move mode" },
      { "<leader>wh", "<cmd>WinShift left<cr>",  desc = "Move current window to left" },
      { "<leader>wl", "<cmd>WinShift right<cr>", desc = "Move current window to right" },
      { "<leader>wk", "<cmd>WinShift up<cr>",    desc = "Move current window to top" },
      { "<leader>wj", "<cmd>WinShift down<cr>",  desc = "Move current window to bottom" },
      { "<leader>wx", "<cmd>WinShift swap<cr>",  desc = "Swap windows" },
    },
  },

  {
    "beauwilliams/focus.nvim",
    opts = {
      hybridnumber = true,
      excluded_filetypes = { "alpha", "neo-tree", "spectre_pannel" },
    },
    keys = {
      { "<leader>Sn", "<cmd>FocusSplitNicely<cr>", desc = "Split nicely" },
      { "<leader>Sc", "<cmd>FocusSplitCycle<cr>",  desc = "Split Cycle" },
      { "<leader>Sh", "<cmd>FocusSplitLeft<cr>",   desc = "Split left" },
      { "<leader>Sl", "<cmd>FocusSplitRight<cr>",  desc = "Split right" },
      { "<leader>Sk", "<cmd>FocusSplitUp<cr>",     desc = "Split up" },
      { "<leader>Sj", "<cmd>FocusSplitDown<cr>",   desc = "Split down" },
    },
  },
}

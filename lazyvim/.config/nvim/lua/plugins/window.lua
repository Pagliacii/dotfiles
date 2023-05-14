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
}

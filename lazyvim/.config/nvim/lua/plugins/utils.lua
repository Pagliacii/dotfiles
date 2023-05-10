return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },

  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    config = function()
      local orgmode = require("orgmode")
      orgmode.setup_ts_grammar()
      orgmode.setup({})
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },

  {
    "wakatime/vim-wakatime",
    event = "UIEnter",
  },
}

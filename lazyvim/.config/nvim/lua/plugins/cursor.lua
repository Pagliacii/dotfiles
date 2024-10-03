return {
  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    cmd = "Cursorword",
    opts = {
      excluded = {
        filetypes = {
          "alpha",
          "dashboard",
          "lazy",
          "TelescopePrompt",
          "noice",
          "glow",
        },
        buftypes = {
          "terminal",
        },
      },
    },
  },

  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    opts = {
      type = "default",
      fancy = {
        enable = true,
      },
      matrix = {
        unstop = true,
      },
      max_threshold = 42,
      disable_float_win = true,
      disabled_filetypes = {
        "noice",
        "TelescopePrompt",
        "NvimTree",
        "neo-tree",
        "dashboard",
        "lazy",
        "Terminal",
        "toggleterm",
      },
    },
  },
}

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
    "mvllow/modes.nvim",
    event = "BufReadPre",
    opts = {
      -- Enable cursor highlights
      set_cursor = false,
      -- Enable line number highlights to match cursonline
      set_number = false,
      -- Disable modes highlights in specified filetypes
      -- Please PR commonly ignored filetypes
      ignore_filetypes = { "NvimTree", "TelescopePrompt", "noice", "glow", "alpha", "dashboard" },
    },
  },

  {
    "sphamba/smear-cursor.nvim",
    event = "BufReadPre",
    opts = {
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      hide_target_hack = false, -- true     boolean
    },
  },
}

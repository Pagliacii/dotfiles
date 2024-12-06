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
    },
  },
}

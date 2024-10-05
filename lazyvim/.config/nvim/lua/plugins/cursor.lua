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
}

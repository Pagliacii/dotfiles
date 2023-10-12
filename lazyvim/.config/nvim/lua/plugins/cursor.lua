return {
  {
    "sontungexpt/stcursorword",
    event = "BufReadPost",
    opts = {
      excluded = {
        filetypes = {
          "alpha",
          "dashboard",
        },
        buftypes = {
          "terminal",
        },
      },
    },
  },
}

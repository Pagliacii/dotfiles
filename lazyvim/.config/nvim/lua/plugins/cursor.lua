return {
  {
    "sontungexpt/stcursorword",
    event = "BufReadPost",
    opts = {
      excluded = {
        filetypes = {
          "alpha",
          "dashboard",
          "lazy",
          "TelescopePrompt",
          "noice",
        },
        buftypes = {
          "terminal",
        },
      },
    },
  },
}

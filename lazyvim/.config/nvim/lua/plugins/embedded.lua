return {
  {
    "tpope/vim-dispatch",
    cmd = {
      "AbortDispatch",
      "Copen",
      "Dispatch",
      "Focus",
      "FocusDispatch",
      "Make",
      "Spawn",
      "Start",
    },
    config = function()
      vim.g.dispatch_no_maps = 1
    end,
  },

  {
    "normen/vim-pio",
    cmd = {
      "PIO",
      "PIOInit",
      "PIOInstall",
      "PIOUninstall",
      "PIONewProject",
      "PIOAddLibrary",
      "PIORemoveLibrary",
    },
  },
}

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

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    ft = { "c", "cpp" },
    opts = {
      extensions = {
        inlay_hints = vim.fn.has("nvim-0.10") == 1,
      },
    },
  },
}
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
    commit = "f677c48a2d90670d47adc05aede72a3bd9a12bcd",
    ft = { "c", "cpp" },
    opts = {
      extensions = {
        inlay_hints = vim.fn.has("nvim-0.10") == 1,
      },
    },
  },

  {
    "RaafatTurki/hex.nvim",
    enabled = vim.fn.executable("xxd") == 1,
    config = true,
    cmd = { "HexDump", "HexAssemble", "HexToggle" },
  },
}

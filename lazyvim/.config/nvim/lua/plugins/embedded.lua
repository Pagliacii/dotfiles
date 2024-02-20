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
    enabled = false,
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
    "anurag3301/nvim-platformio.lua",
    dependencies = {
      { "akinsho/nvim-toggleterm.lua" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = {
      "Pioinit",
      "Piorun",
      "Piocmd",
      "Piolib",
      "Piomon",
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

  {
    "RaafatTurki/hex.nvim",
    enabled = vim.fn.executable("xxd") == 1,
    config = true,
    cmd = { "HexDump", "HexAssemble", "HexToggle" },
  },
}

local filetypes = { "c", "cpp", "cmake" }
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = filetypes,
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "clang-format",
      })
    end,
  },

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
    ft = filetypes,
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

  {
    "jedrzejboczar/nvim-dap-cortex-debug",
    lazy = true,
    ft = filetypes,
    dependencies = { "mfussenegger/nvim-dap" },
    config = true,
  },
}

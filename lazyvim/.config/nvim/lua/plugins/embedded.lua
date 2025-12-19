local filetypes = { "c", "cpp", "cmake", "make" }

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
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      if not opts.sources then
        opts.sources = {}
      end
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.diagnostics.cppcheck,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "arduino-language-server",
        "checkmake",
        "clang-format",
        "cmakelint",
        "mbake",
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

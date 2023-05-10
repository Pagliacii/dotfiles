return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "flake8",
        "pyright",
        "ruff",
      },
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "debugpy" })
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    config = function()
      local path = require("mason-core.path")
      local bin_folder = "bin"
      local suffix = ""
      if (jit and jit.os == "Windows") or vim.loop.os_uname().sysname == "Windows_NT" then
        bin_folder = "Scripts"
        suffix = ".exe"
      end
      require("dap-python").setup(path.concat({
        path.package_prefix("debugpy"),
        "venv",
        bin_folder,
        "python" .. suffix,
      }))
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
          filetypes = { "python" },
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = false,
              },
            },
          },
        },
      },
    },
  },
}

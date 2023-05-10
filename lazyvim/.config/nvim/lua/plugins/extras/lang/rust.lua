return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "rustfmt",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {
          filetypes = { "rust" },
          root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
          settings = {
            ["rust-analyzer"] = {
              assist = {
                emitMustUse = true,
              },
              cargo = {
                features = "all",
              },
              checkOnSave = true,
              check = {
                command = "clippy",
                features = "all",
              },
              hover = {
                actions = {
                  references = {
                    enable = true,
                  },
                },
              },
              inlayHints = {
                bindingModeHints = {
                  enable = true,
                },
                closureReturnTypeHints = {
                  enable = "always",
                },
                closureStyle = "rust_analyzer",
                lifetimeElisionHints = {
                  enable = "always",
                  useParameterNames = true,
                },
              },
            },
          },
        },
      },
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb" })
    end,
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = true,
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    ft = { "rust" },
    config = function()
      local path = require("mason-core.path")
      local codelldb_path = path.concat({
        path.package_prefix("codelldb"),
        "extension",
        "adapter",
        "codelldb" .. (vim.fn.has("win32") and ".exe" or ""),
      })
      local liblldb_path = path.concat({
        path.package_prefix("codelldb"),
        "extension",
        "lldb",
        "bin",
        "liblldb" .. (vim.fn.has("win32") and ".dll" or ""),
      })
      require("mason-nvim-dap").setup({
        handlers = {
          codelldb = function(config)
            config.adapters = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })
      return true
    end,
    cmd = { "RustOpenCargo", "RustRunnables", "RustDebuggables" },
    keys = {
      { "<leader>rc", "<cmd> RustOpenCargo<CR>", desc = "open Cargo.toml" },
      { "<leader>rd", "<cmd> RustDebuggables<CR>", desc = "debuggable targets" },
      { "<leader>rr", "<cmd> RustRunnables<CR>", desc = "runnable targets" },
    },
  },
}

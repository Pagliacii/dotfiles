return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust-analyzer",
        "rustfmt",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "rust" },
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.rustfmt,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      ---@type lspconfig.options
      vim.list_extend(opts.servers, {
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
      })
    end,
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
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },
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
      local adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)

      require("dap").configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = function()
            local job = require("plenary.job")
            job
              :new({
                command = "cargo",
                args = { "build" },
                cwd = vim.fn.getcwd(),
              })
              :sync()
            return path.concat({ "${workspaceFolder}", "target", "debug", "${workspaceFolderBasename}" })
          end,
        },
        {
          name = "Attach",
          type = "codelldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
        },
      }
      require("mason-nvim-dap").setup({
        handlers = {
          codelldb = function(config)
            config = vim.tbl_deep_extend("force", config, {
              adapters = adapter,
              filetypes = { "rust" },
            })
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      local opts = {
        dap = {
          adapter = adapter,
        },
      }
      require("rust-tools").setup(opts)
      return true
    end,
    cmd = { "RustOpenCargo", "RustRunnables", "RustDebuggables" },
    keys = {
      { "<leader>rc", "<cmd> RustOpenCargo<cr>", desc = "Open Cargo.toml" },
      { "<leader>rd", "<cmd> RustDebuggables<cr>", desc = "Debuggable targets" },
      { "<leader>rr", "<cmd> RustRunnables<cr>", desc = "Runnable targets" },
    },
  },
}

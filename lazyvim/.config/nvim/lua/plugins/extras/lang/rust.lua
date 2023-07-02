local filetypes = { "rust" }

return {
  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rust-analyzer",
        "rustfmt",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.rustfmt,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = filetypes,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {
          filetypes = filetypes,
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
    "simrat39/rust-tools.nvim",
    ft = filetypes,
    cmd = { "RustOpenCargo", "RustRunnables", "RustDebuggables" },
    keys = {
      { "<leader>rc", "<cmd> RustOpenCargo<cr>", desc = "Open Cargo.toml" },
      { "<leader>rd", "<cmd> RustDebuggables<cr>", desc = "Debuggable targets" },
      { "<leader>rr", "<cmd> RustRunnables<cr>", desc = "Runnable targets" },
    },
  },
}

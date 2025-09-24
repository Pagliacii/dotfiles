local filetypes = { "python" }

-- ref: https://beta.ruff.rs/docs/rules
local rules = {
  "A", -- flake8-builtins
  "ANN", -- flake8-annotations
  "ARG", -- flake8-unused-arguments
  "B", -- flake8-bugbear
  "COM", -- flake8-commas
  "C4", -- flake8-comprehensions
  "FA", -- flake8-future-annotations
  "RET", -- flake8-return
  "SLF", -- flake8-self
  "E", -- pycodestyle error
  "F", -- pyflakes
  "I", -- isort
  "N", -- pep8-naming
  "W", -- pycodestyle warning
}

return {
  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "pyright",
        "ruff",
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
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
          filetypes = filetypes,
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "pyrightconfig.json",
            "ruff.toml",
            "venv",
            ".git"
          ),
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            --- Setup capabilities to support utf-16, since copilot.lua only works with utf-16
            --- this is a workaround to the limitations of copilot language server
            capabilities = vim.tbl_deep_extend("force", capabilities, {
              offsetEncoding = { "utf-16" },
              general = {
                positionEncodings = { "utf-16" },
              },
            })

            capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            return capabilities
          end)(),
          on_attach = function(client, _)
            client.server_capabilities.codeActionProvider = false
          end,
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                indexing = true,
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          capabilities = (function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            --- Setup capabilities to support utf-16, since copilot.lua only works with utf-16
            --- this is a workaround to the limitations of copilot language server
            capabilities = vim.tbl_deep_extend("force", capabilities, {
              offsetEncoding = { "utf-16" },
              general = {
                positionEncodings = { "utf-16" },
              },
            })

            return capabilities
          end)(),
          init_options = {
            settings = {
              logLevel = "error",
              -- Any extra CLI arguments for `ruff` go here.
              args = {
                "--select",
                table.concat(rules, ","),
              },
            },
          },
        },
      },
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    cmd = { "VenvSelect", "VenvSelectCached" },
    opts = function(_, opts)
      opts.dap_enabled = true
    end,
    ft = filetypes,
    keys = {
      { "<leader>cv", false },
      { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", noremap = true },
      { "<leader>pc", "<cmd>VenvSelectCached<cr>", desc = "Select VirtualEnv (cached)", noremap = true },
    },
  },
}

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "goimports-reviser",
        "golines",
      })
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "delve" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "go",
        "gosum",
        "gomod",
        "gowork",
      })
    end,
  },

  {
    "leoluz/nvim-dap-go",
    ft = { "go" },
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function(_, opts)
      ---@type lspconfig.options
      vim.list_extend(opts.servers, {
        gopls = {
          filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" },
          root_dir = require("lspconfig.util").root_pattern(".git", "go.work", "go.mod"),
          settings = {
            gopls = {
              analyses = {
                nilness = true, -- check for redundant or impossible nil comparisons
                shadow = true, -- check for possible unintended shadowing of variables
                unusedparams = true, -- check for unused parameters of functions
                unusedwrite = true, -- check for unused writes
                useany = true, -- check for constraints that could be simplified to "any"
                unusedvariable = true, -- check for unused variables
              },
              gofumpt = true, -- if we should run `gofumpt` formatting
              usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
              hints = {
                assignVariableTypes = true, -- inlay hints for variable types in assign statements
                compositeLiteralFields = true, -- inlay hints for composite literal field names
                compositeLiteralTypes = true, -- inlay hints for composite literal types
                constantValues = true, -- inlay hints for constant values
                functionTypeParameters = true, -- inlay hints for implicit type parameters on generic functions
                parameterNames = true, -- inlay hints for parameter names
                rangeVariableTypes = true, -- inlay hints for variable types in range statements
              },
            },
          },
        },
      })
    end,
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = { "go", "gomod", "gosum" },
    event = { "BufReadPre *.go" },
    opts = {
      inlay_hints = {
        type_hints = { prefix = "=> " },
      },
    },
    config = true,
    keys = {
      {
        "<leader>ch",
        function()
          require("lsp-inlayhints").toggle()
        end,
        desc = "Toggle Inlay Hints",
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "go" },
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.gofumpt,
        require("null-ls").builtins.formatting.goimports_reviser,
        require("null-ls").builtins.formatting.golines,
      })
    end,
  },
}

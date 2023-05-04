-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
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
        gopls = {
          filetypes = { "go" },
          settings = {
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
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "go",
        "python",
        "regex",
        "rust",
        "toml",
        "vim",
        "yaml",
      })
    end,
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "ruff",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        find_files = {
          hidden = true,
        },
      },
    },
  },

  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },

  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    config = function()
      local orgmode = require("orgmode")
      orgmode.setup_ts_grammar()
      orgmode.setup({})
    end,
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = { "go" },
    opts = {
      inlay_hints = {
        type_hints = { prefix = "=> " },
      },
    },
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    ft = { "rust" },
  },
}

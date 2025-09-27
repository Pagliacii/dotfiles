local filetypes = { "rust" }
local prefix = "<leader>pr"

return {
  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "codelldb",
        "rust-analyzer",
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
    "mrcjkb/rustaceanvim",
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", prefix .. "c", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", prefix .. "C", function()
            vim.cmd.RustLsp("openCargo")
          end, { desc = "Open Cargo.toml", buffer = bufnr })
          vim.keymap.set("n", prefix .. "d", function()
            vim.cmd.RustLsp("debug")
          end, { desc = "Debug target", buffer = bufnr })
          vim.keymap.set("n", prefix .. "D", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Debuggables", buffer = bufnr })
          vim.keymap.set("n", prefix .. "r", function()
            vim.cmd.RustLsp("run")
          end, { desc = "Run target", buffer = bufnr })
          vim.keymap.set("n", prefix .. "R", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "Runnables", buffer = bufnr })
          vim.keymap.set("n", prefix .. "t", function()
            vim.cmd.RustLsp("testables")
          end, { desc = "Testables", buffer = bufnr })
          vim.keymap.set("n", prefix .. "m", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Expand macro", buffer = bufnr })
          vim.keymap.set("n", prefix .. "M", function()
            vim.cmd.RustLsp("rebuildProcMacros")
          end, { desc = "Rebuild proc macros", buffer = bufnr })
          vim.keymap.set("n", prefix .. "p", function()
            vim.cmd.RustLsp({ "moveItem", "up" })
          end, { desc = "Move item up", buffer = bufnr })
          vim.keymap.set("n", prefix .. "n", function()
            vim.cmd.RustLsp({ "moveItem", "down" })
          end, { desc = "Move item down", buffer = bufnr })
          vim.keymap.set("n", prefix .. "h", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { desc = "Hover actions", buffer = bufnr })
          vim.keymap.set("n", prefix .. "H", function()
            vim.cmd.RustLsp({ "hover", "range" })
          end, { desc = "Hover range", buffer = bufnr })
          vim.keymap.set("n", prefix .. "E", function()
            vim.cmd.RustLsp({ "explainError", "cycle" })
          end, { desc = "Explain error cycle", buffer = bufnr })
          vim.keymap.set("n", prefix .. "e", function()
            vim.cmd.RustLsp({ "explainError", "current" })
          end, { desc = "Explain error current", buffer = bufnr })
          vim.keymap.set("n", prefix .. "g", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "current" })
          end, { desc = "Render diagnostic current", buffer = bufnr })
          vim.keymap.set("n", prefix .. "G", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
          end, { desc = "Render diagnostic cycle", buffer = bufnr })
          vim.keymap.set("n", prefix .. "o", function()
            vim.cmd.RustLsp("openDocs")
          end, { desc = "Open docs.rs", buffer = bufnr })
          vim.keymap.set("n", prefix .. "P", function()
            vim.cmd.RustLsp("parentModule")
          end, { desc = "Parent module", buffer = bufnr })
          vim.keymap.set("n", prefix .. "w", function()
            vim.cmd.RustLsp({ "workspaceSymbol", "onlyTypes" })
          end, { desc = "Workspace symbol search", buffer = bufnr })
          vim.keymap.set("n", prefix .. "W", function()
            vim.cmd.RustLsp({ "workspaceSymbol", "allSymbols" })
          end, { desc = "Workspace symbol search all", buffer = bufnr })
          vim.keymap.set("n", prefix .. "j", function()
            vim.cmd.RustLsp("joinLines")
          end, { desc = "Join lines", buffer = bufnr })
          vim.keymap.set("v", prefix .. "s", function()
            vim.cmd.RustLsp("ssr")
          end, { desc = "Search the selection", buffer = bufnr })
          vim.keymap.set("n", prefix .. "G", function()
            vim.cmd.RustLsp("crateGraph")
          end, { desc = "View crate graph", buffer = bufnr })
          vim.keymap.set("n", prefix .. "T", function()
            vim.cmd.RustLsp("syntaxTree")
          end, { desc = "View syntax tree", buffer = bufnr })
          vim.keymap.set("n", prefix .. "f", function()
            vim.cmd.RustLsp("flyCheck")
          end, { desc = "Fly check", buffer = bufnr })
          vim.keymap.set("n", prefix .. "vh", function()
            vim.cmd.RustLsp({ "view", "hir" })
          end, { desc = "View HIR", buffer = bufnr })
          vim.keymap.set("n", prefix .. "vm", function()
            vim.cmd.RustLsp({ "view", "mir" })
          end, { desc = "View MIR", buffer = bufnr })
          vim.keymap.set("n", prefix .. "uh", function()
            vim.cmd.RustLsp({ "unpretty", "hir" })
          end, { desc = "Unpretty HIR", buffer = bufnr })
          vim.keymap.set("n", prefix .. "um", function()
            vim.cmd.RustLsp({ "unpretty", "mir" })
          end, { desc = "Unpretty MIR", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
  },
}

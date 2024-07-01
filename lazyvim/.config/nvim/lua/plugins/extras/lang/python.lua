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
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "ruff-lsp",
      })
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = filetypes,
    config = function()
      local path = require("mason-core.path")
      local bin_folder = "bin"
      local suffix = ""
      if (jit and jit.os == "Windows") or vim.loop.os_uname().sysname == "Windows_NT" then
        bin_folder = "Scripts"
        suffix = ".exe"
      end
      local interpreter = path.concat({ bin_folder, "python" .. suffix })
      require("dap-python").setup(path.concat({
        path.package_prefix("debugpy"),
        "venv",
        interpreter,
      }))

      local dap = require("dap")
      local job = require("plenary.job")
      local function auto_detect(...)
        local cwd = vim.fn.getcwd()
        local venv_path = "python"
        local local_venv_path = path.concat({
          cwd,
          "venv",
          interpreter,
        })
        local dot_venv_path = path.concat({
          cwd,
          ".venv",
          interpreter,
        })
        if vim.fn.executable(local_venv_path) == 1 then
          venv_path = local_venv_path
        elseif vim.fn.executable(dot_venv_path) == 1 then
          venv_path = dot_venv_path
        elseif vim.fn.executable("poetry") == 1 then
          job
            :new({
              command = "poetry",
              args = { "env", "info", "-p" },
              cwd = cwd,
              on_stdout = function(_, output)
                venv_path = path.concat({
                  output,
                  interpreter,
                })
              end,
            })
            :sync()
        end
        return venv_path
      end
      dap.configurations.python = vim.list_extend({
        {
          type = "python",
          request = "launch",
          name = "Launch file (auto detect)",
          program = "${file}",
          pythonPath = auto_detect,
        },
        {
          name = "Attach process",
          type = "python",
          request = "attach",
          pid = require("dap.utils").pick_process,
        },
      }, dap.configurations.python)
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
        ruff_lsp = {
          filetypes = filetypes,
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "pyrightconfig.json",
            "ruff.toml",
            "venv",
            ".git"
          ),
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = {
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
    branch = "regexp", -- Use this branch for the new version
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    cmd = "VenvSelect",
    opts = function(_, opts)
      opts.dap_enabled = true
    end,
    ft = filetypes,
    keys = {
      { "<leader>cv", false },
      { "<leader>pv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", noremap = true },
    },
  },
}

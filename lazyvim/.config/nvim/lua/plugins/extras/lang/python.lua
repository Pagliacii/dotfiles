local filetypes = { "python" }

return {
  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "flake8",
        "isort",
        "pyright",
        "ruff",
        "mypy",
      })
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "debugpy" })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
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
          local poetry_interpreter = ""
          job
            :new({
              command = "poetry",
              args = { "env", "info", "-p" },
              cwd = cwd,
              on_stdout = function(_, output)
                poetry_interpreter = path.concat({
                  output,
                  interpreter,
                })
              end,
            })
            :sync()
          venv_path = poetry_interpreter
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
          root_dir = require("lspconfig.util").root_pattern("pyproject.toml", "venv", ".git"),
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = false,
              },
            },
          },
        },
        ruff_lsp = {
          filetypes = filetypes,
          root_dir = require("lspconfig.util").root_pattern("pyproject.toml", "venv", ".git"),
          settings = {},
        },
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.ruff,
      })
    end,
  },
}

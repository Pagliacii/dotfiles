local function go_mod_init()
  local mod_name = vim.fn.input("Please enter the module name: ")
  if #mod_name ~= 0 then
    vim.cmd([[ GoMod init ]] .. mod_name)
  end
end
local function go_impl()
  local interface_name = vim.fn.input("Which interface to implement: ")
  if #interface_name ~= 0 then
    vim.cmd([[ GoImpl ]] .. interface_name)
  end
end
local function go_get()
  local link = vim.fn.input("Where to get the package: ")
  if #link ~= 0 then
    vim.cmd([[ GoGet ]] .. link)
  end
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "goimports-reviser",
        "golines",
        "gomodifytags",
        "gotests",
        "iferr",
        "impl",
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
    "olexsmir/gopher.nvim",
    ft = { "go" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      { "<leader>Ga", "<cmd>GoTestAdd<cr>", desc = "Add one test", silent = true },
      { "<leader>GA", "<cmd>GoTestsAll<cr>", desc = "Add all tests", silent = true },
      { "<leader>Gj", "<cmd>GoTagAdd json<cr>", desc = "Add json tag", silent = true },
      { "<leader>GJ", "<cmd>GoTagRm json<cr>", desc = "Remove json tag", silent = true },
      { "<leader>Gy", "<cmd>GoTagAdd yaml<cr>", desc = "Add yaml tag", silent = true },
      { "<leader>GY", "<cmd>GoTagRm yaml<cr>", desc = "Remove yaml tag", silent = true },
      { "<leader>Gm", go_mod_init, desc = "go mod init", silent = true },
      { "<leader>Gi", go_impl, desc = "Interface implementation", silent = true },
      { "<leader>Gg", go_get, desc = "go get", silent = true },
      { "<leader>Gc", "<cmd>GoGenerate<cr>", desc = "go generate (cwd)", silent = true },
      { "<leader>GC", "<cmd>GoGenerate %<cr>", desc = "go generate (current file)", silent = true },
      { "<leader>Gd", "<cmd>GoCmt<cr>", desc = "Doc comment", silent = true },
      { "<leader>Ge", "<cmd>GoIfErr<cr>", desc = "Insert iferr", silent = true },
    },
    config = function(_, opts)
      require("gopher").setup(opts)
      require("gopher.dap").setup()
    end,
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

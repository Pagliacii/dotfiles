local filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" }

return {
  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gopls",
        "gofumpt",
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
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "delve" })
    end,
  },

  {
    "leoluz/nvim-dap-go",
    ft = filetypes,
    config = true,
  },

  {
    "olexsmir/gopher.nvim",
    ft = filetypes,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = function(_, keys)
      local function go_mod_init()
        local mod_name = vim.fn.input("Please enter the module name: ")
        if #mod_name ~= 0 then
          vim.cmd([[ GoMod init ]] .. mod_name)
        end
      end
      local function go_get()
        local link = vim.fn.input("Where to get the package: ")
        if #link ~= 0 then
          vim.cmd([[ GoGet ]] .. link)
        end
      end

      vim.list_extend(keys, {
        { "<leader>Ga", "<cmd>GoTestAdd<cr>", desc = "Add one test", silent = true },
        { "<leader>GA", "<cmd>GoTestsAll<cr>", desc = "Add all tests", silent = true },
        { "<leader>Gj", "<cmd>GoTagAdd json<cr>", desc = "Add json tag", silent = true },
        { "<leader>GJ", "<cmd>GoTagRm json<cr>", desc = "Remove json tag", silent = true },
        { "<leader>Gy", "<cmd>GoTagAdd yaml<cr>", desc = "Add yaml tag", silent = true },
        { "<leader>GY", "<cmd>GoTagRm yaml<cr>", desc = "Remove yaml tag", silent = true },
        { "<leader>Gm", go_mod_init, desc = "go mod init", silent = true },
        { "<leader>Gg", go_get, desc = "go get", silent = true },
        { "<leader>Gc", "<cmd>GoGenerate<cr>", desc = "go generate (cwd)", silent = true },
        { "<leader>GC", "<cmd>GoGenerate %<cr>", desc = "go generate (current file)", silent = true },
        { "<leader>Gd", "<cmd>GoCmt<cr>", desc = "Doc comment", silent = true },
        { "<leader>Ge", "<cmd>GoIfErr<cr>", desc = "Insert iferr", silent = true },
      })
      return keys
    end,
    config = function(_, opts)
      require("gopher").setup(opts)
      require("gopher.dap").setup()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = filetypes,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        gopls = {
          filetypes = filetypes,
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
      },
    },
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    dependencies = "neovim/nvim-lspconfig",
    ft = filetypes,
    event = { "BufReadPre *.go" },
    opts = {
      inlay_hints = {
        type_hints = { prefix = "=> " },
      },
    },
    keys = {
      {
        "<leader>Gh",
        function()
          require("lsp-inlayhints").toggle()
        end,
        desc = "Toggle Inlay Hints",
      },
    },
  },

  {
    "edolphin-ydf/goimpl.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("telescope").load_extension("goimpl")
    end,
    ft = filetypes,
    keys = {
      { "<leader>Gi", "<cmd>Telescope goimpl<cr>", desc = "Interface stub", silent = true },
    },
  },
}

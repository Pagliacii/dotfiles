local filetypes = { "go", "gomod", "gosum", "gowork", "gotmpl" }
local prefix = "<leader>pg"

return {
  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
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
        { prefix, "", ft = filetypes },
        { prefix .. "a", "<cmd>GoTestAdd<cr>", desc = "Add one test", silent = true, ft = filetypes },
        { prefix .. "A", "<cmd>GoTestsAll<cr>", desc = "Add all tests", silent = true, ft = filetypes },
        { prefix .. "j", "<cmd>GoTagAdd json<cr>", desc = "Add json tag", silent = true, ft = filetypes },
        { prefix .. "J", "<cmd>GoTagRm json<cr>", desc = "Remove json tag", silent = true, ft = filetypes },
        { prefix .. "y", "<cmd>GoTagAdd yaml<cr>", desc = "Add yaml tag", silent = true, ft = filetypes },
        { prefix .. "Y", "<cmd>GoTagRm yaml<cr>", desc = "Remove yaml tag", silent = true, ft = filetypes },
        { prefix .. "m", go_mod_init, desc = "go mod init", silent = true, ft = filetypes },
        { prefix .. "G", go_get, desc = "go get", silent = true, ft = filetypes },
        { prefix .. "c", "<cmd>GoGenerate<cr>", desc = "go generate (cwd)", silent = true, ft = filetypes },
        { prefix .. "C", "<cmd>GoGenerate %<cr>", desc = "go generate (current file)", silent = true, ft = filetypes },
        { prefix .. "d", "<cmd>GoCmt<cr>", desc = "Doc comment", silent = true, ft = filetypes },
        { prefix .. "e", "<cmd>GoIfErr<cr>", desc = "Insert iferr", silent = true, ft = filetypes },
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
      { prefix .. "i", "<cmd>Telescope goimpl<cr>", desc = "Interface stub", silent = true, ft = filetypes },
    },
  },
}

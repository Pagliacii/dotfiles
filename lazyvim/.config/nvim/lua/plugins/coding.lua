return {
  {
    "hrsh7th/nvim-cmp",
    cond = false,
    ---@param opts cmp.ConfigSchema
    dependencies = {
      { "lukas-reineke/cmp-rg" },
      { "onsails/lspkind.nvim" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      table.insert(cmp.mapping.preset, {
        -- Accept multi-line completion
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Insert, select = false }),
      })
      opts.sources = cmp.config.sources({
        -- { name = "fittencode", group_index = 1 },
        { name = "nvim_lsp" },
        { name = "path" },
        {
          name = "rg",
          keyword_length = 3,
        },
        { name = "emoji" },
        { name = "neorg" },
        { name = "orgmode" },
      }, {
        { name = "buffer" },
      })
      opts.formatting = vim.tbl_extend("force", opts.formatting or {}, {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
          symbol_map = {
            -- FittenCode = "",
            -- Codeium = "",
          },
        }),
      })

      -- From tjdevries/config.nvim
      -- : https://github.com/tjdevries/config.nvim/blob/784dc2623b66bfdda53b59de776e9c7d4a186d20/lua/custom/completion.lua#L38-L44
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })

      cmp.setup.filetype("DressingInput", {
        sources = cmp.config.sources({ { name = "omni" } }),
      })

      return opts
    end,
  },

  {
    "dnlhc/glance.nvim",
    config = true,
    cmd = { "Glance" },
    keys = {
      { "gpr", "<cmd>Glance references<cr>", desc = "Peek references", noremap = true },
      { "gpd", "<cmd>Glance definitions<cr>", desc = "Peek definitions", noremap = true },
      { "gpt", "<cmd>Glance type_definitions<cr>", desc = "Peek type definitions", noremap = true },
      { "gpi", "<cmd>Glance implementations<cr>", desc = "Peek implementations", noremap = true },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      if not opts.sources then
        opts.sources = {}
      end
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.codespell.with({
          extra_args = { "-I", vim.fn.stdpath("config") .. "/spell/en.utf-8.add" },
        }),
        null_ls.builtins.completion.spell,
      })
    end,
  },

  {
    "stevearc/overseer.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      templates = { "builtin", "user" },
    },
  },

  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "gj",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
      {
        "gk",
        function()
          require("wtf").ai()
        end,
        desc = "Search diagnostic with AI",
      },
    },
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      {
        "<leader>ty",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Yank history",
      },
    },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      -- load refactoring Telescope extension
      if LazyVim.has("telescope.nvim") then
        require("telescope").load_extension("refactoring")
      end
    end,
    cmd = { "Refactor" },
    keys = {
      {
        "<leader>cRs",
        function()
          require("telescope").extensions.refactoring.refactors()
        end,
        mode = "v",
        desc = "Refactor",
      },
      {
        "<leader>cRi",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        "<leader>cRb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
      {
        "<leader>cRf",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        desc = "Extract Block To File",
      },
      {
        "<leader>cRP",
        function()
          require("refactoring").debug.printf({ below = true })
        end,
        desc = "Debug Print",
      },
      {
        "<leader>cRp",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        desc = "Debug Print Variable",
      },
      {
        "<leader>cRc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
      {
        "<leader>cRf",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "<leader>cRF",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        "<leader>cRx",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        "<leader>cRp",
        function()
          require("refactoring").debug.print_var()
        end,
        mode = "v",
        desc = "Debug Print Variable",
      },
    },
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
    },
  },

  {
    "chrisgrieser/nvim-puppeteer",
    lazy = false, -- plugin lazy-loads itself.
  },

  {
    "piersolenski/import.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      picker = "snacks",
    },
    keys = {
      { "<leader>ti", "<cmd>Import<cr>", desc = "Import modules", noremap = true, silent = true },
    },
  },

  {
    "gregorias/coerce.nvim",
    tag = "v4.1.0",
    config = true,
    event = "BufReadPre",
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {
      highlight = {
        comments_only = false,
      },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      { "onsails/lspkind.nvim" },
      { "xzbdmw/colorful-menu.nvim", config = true },
      -- for avante source
      "Kaiser-Yang/blink-cmp-avante",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },

      -- experimental signature help support
      signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "avante", "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}

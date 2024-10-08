return {
  {
    "hrsh7th/nvim-cmp",
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
      opts.sources = cmp.config.sources(
        vim.list_extend(opts.sources, {
          { name = "emoji" },
          {
            name = "rg",
            keyword_length = 3,
          },
          { name = "neorg" },
          { name = "orgmode" },
        }),
        { name = "buffer" }
      )
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
    "simrat39/symbols-outline.nvim",
    enabled = false,
    cmd = { "SymbolsOutline" },
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      symbols = {
        File = { icon = "󰈔", hl = "@text.uri" },
        Module = { icon = "󰆧", hl = "@namespace" },
        Namespace = { icon = "󱃖", hl = "@namespace" },
        Package = { icon = "󰏗", hl = "@namespace" },
        Field = { icon = "󰮄", hl = "@field" },
        Interface = { icon = "󰜰", hl = "@type" },
        Array = { icon = "󰅪", hl = "@constant" },
        Component = { icon = "󰡀", hl = "@function" },
        Fragment = { icon = "󰅴", hl = "@constant" },
        Class = { icon = "", hl = "@type" },
        String = { icon = "", hl = "@string" },
        Struct = { icon = "", hl = "@type" },
        Event = { icon = "", hl = "@type" },
        TypeParameter = { icon = "", hl = "@parameter" },
      },
    },
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
    "trimclain/builder.nvim",
    cmd = "Build",
    keys = {
      {
        "<leader>cb",
        function()
          require("builder").build()
        end,
        desc = "Build",
      },
    },
    opts = {
      commands = {
        -- add your commands
        c = "clang % -o $basename.o && ./$basename.o",
        cpp = "clang++ % -o $basename.o && ./$basename.o",
        go = "go run %",
        markdown = "glow %",
        python = "python %",
        rust = "cargo run",
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
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
    keys = {
      { "<leader>ti", "<cmd>Telescope import<cr>", desc = "Import modules", noremap = true, silent = true },
    },
  },

  {
    "gregorias/coerce.nvim",
    tag = "v0.3",
    config = true,
    keys = {
      { "crc", mode = { "n", "v" }, desc = "camelCase" },
      { "crd", mode = { "n", "v" }, desc = "dot.case" },
      { "crk", mode = { "n", "v" }, desc = "kebab-case" },
      { "crn", mode = { "n", "v" }, desc = "n12e" },
      { "crp", mode = { "n", "v" }, desc = "PascalCase" },
      { "crs", mode = { "n", "v" }, desc = "snake_case" },
      { "cru", mode = { "n", "v" }, desc = "UPPER_CASE" },
      { "cr/", mode = { "n", "v" }, desc = "path/case" },
    },
  },

  {
    "LudoPinelli/comment-box.nvim",
    keys = {
      { "<leader>Cb", "<cmd>CBccbox<cr>", mode = { "n", "v" }, desc = "Box Title", noremap = true, silent = true },
      { "<leader>Ct", "<cmd>CBllline<cr>", mode = { "n", "v" }, desc = "Titled Line", noremap = true, silent = true },
      { "<leader>Cl", "<cmd>CBlline<cr>", mode = { "n", "v" }, desc = "Simple Line", noremap = true, silent = true },
      { "<leader>Cm", "<cmd>CBllbox14<cr>", mode = { "n", "v" }, desc = "Marked", noremap = true, silent = true },
      { "<leader>Cd", "<cmd>CBd<cr>", mode = { "n", "v" }, desc = "Remove a box", noremap = true, silent = true },
    },
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
}

return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    dependencies = {
      { "lukas-reineke/cmp-rg" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      table.insert(cmp.mapping.preset, {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      })
      table.insert(cmp.mapping.preset, {
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      })
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emoji" },
        {
          name = "rg",
          keyword_length = 3,
        },
      }))
    end,
  },

  {
    "rmagatti/goto-preview",
    config = true,
    keys = function(_, keys)
      local cmd_factory = function(cmd)
        return string.format("<cmd>lua require('goto-preview').%s()<cr>", cmd)
      end
      vim.list_extend(keys, {
        { "gpd", cmd_factory("goto_preview_definition"), desc = "Preview definition", noremap = true },
        { "gpt", cmd_factory("goto_preview_type_definition"), desc = "Preview type definition", noremap = true },
        { "gpi", cmd_factory("goto_preview_implementation"), desc = "Preview implementation", noremap = true },
        { "gpr", cmd_factory("goto_preview_references"), desc = "Preview references", noremap = true },
        { "gpp", cmd_factory("close_all_win"), desc = "Close preview window", noremap = true },
      })
      return keys
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      if not opts.sources then
        opts.sources = {}
      end
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.codespell,
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
    opts = {
      templates = { "builtin", "user" },
    },
    cmd = {
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerToggle",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    keys = {
      { "<leader>Rr", "<cmd>OverseerRun<cr>", desc = "Run a task", noremap = true },
      { "<leader>Rl", "<cmd>OverseerToggle!<cr>", desc = "Task list", noremap = true },
    },
  },

  {
    "michaelb/sniprun",
    enabled = not jit.os:find("Windows"),
    build = "bash install.sh 1",
    cmd = { "SnipRun", "SnipClose", "SnipReset", "SnipInfo" },
    opts = {
      display = {
        "VirtualTextOk",
        "VirtualTextError",
      },
    },
    keys = {
      { "<leader>Rs", "<cmd>SnipRun<cr>", mode = { "n", "v" }, desc = "SnipRun", noremap = true },
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
      -- load refactoring Telescope extension
      require("telescope").load_extension("refactoring")
    end,
    cmd = { "Refactor" },
    keys = {
      {
        "<leader>cR",
        function()
          require("telescope").extensions.refactoring.refactors()
        end,
        desc = "Refactor",
      },
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
}

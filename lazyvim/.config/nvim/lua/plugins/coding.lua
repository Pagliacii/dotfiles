return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
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
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources, {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.codespell,
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = function()
      require("symbols-outline").setup({
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
      })
    end,
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
      { "<leader>R", "<cmd>OverseerRun<cr>", desc = "Run a task", noremap = true },
      { "<leader>L", "<cmd>OverseerToggle!<cr>", desc = "Task list", noremap = true },
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
      { "<leader>S", "<cmd>SnipRun<cr>", mode = { "n", "v" }, desc = "SnipRun", noremap = true },
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
}

return {
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "go",
        "gomod",
        "gosum",
        "python",
        "regex",
        "rust",
        "toml",
        "vim",
        "yaml",
      })
    end,
  },

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
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "crates" } }))
    end,
  },

  {
    "rmagatti/goto-preview",
    config = true,
    keys = function(_, keys)
      local wk = require("which-key")
      wk.register({ ["gp"] = { name = "+preview" } })
      local preview = require("goto-preview")
      vim.list_extend(keys, {
        { "gpd", preview.goto_preview_definition, desc = "Preview definition", noremap = true },
        { "gpt", preview.goto_preview_type_definition, desc = "Preview type definition", noremap = true },
        { "gpi", preview.goto_preview_implementation, desc = "Preview implementation", noremap = true },
        { "gpr", preview.goto_preview_references, desc = "Preview references", noremap = true },
        { "gpp", preview.close_all_win, desc = "Close preview window", noremap = true },
      })
      return keys
    end,
  },
}

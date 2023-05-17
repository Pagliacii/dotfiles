return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "selene",
        "stylua",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "luadoc",
        "luap",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "lua" },
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.diagnostics.selene,
        require("null-ls").builtins.formatting.stylua,
      })
    end,
  },
}

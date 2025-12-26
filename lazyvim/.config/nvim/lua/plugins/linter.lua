return {
  {
    "chrisgrieser/nvim-rulebook",
    keys = {
      {
        "<leader>cI",
        function()
          require("rulebook").ignoreRule()
        end,
        desc = "Ignore rule",
      },
      {
        "<leader>cL",
        function()
          require("rulebook").lookupRule()
        end,
        desc = "Lookup rule",
      },
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
        null_ls.builtins.diagnostics.spectral,
        null_ls.builtins.diagnostics.yamllint,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "spectral-language-server",
        "yamllint",
      })
    end,
  },
}

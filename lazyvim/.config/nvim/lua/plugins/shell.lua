return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "bash-language-server",
        "shellharden",
        "shfmt",
      })
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
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.hover.printenv,
      })
    end,
  },
}

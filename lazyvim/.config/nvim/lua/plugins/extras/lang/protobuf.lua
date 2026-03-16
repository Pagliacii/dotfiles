local filetypes = { "proto" }
return {
  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "buf",
        "protolint",
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.diagnostics.protolint,
        null_ls.builtins.formatting.buf,
      })
    end,
  },
}

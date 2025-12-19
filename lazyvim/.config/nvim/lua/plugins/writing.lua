return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      if not opts.sources then
        opts.sources = {}
      end
      vim.list_extend(opts.sources, {
        null_ls.builtins.code_actions.proselint,
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.codespell.with({
          extra_args = { "-I", vim.fn.stdpath("config") .. "/spell/en.utf-8.add" },
        }),
        null_ls.builtins.diagnostics.proselint,
        null_ls.builtins.formatting.codespell,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "codespell",
        "proselint",
        "shellcheck",
      })
    end,
  },
}

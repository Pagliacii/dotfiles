local filetypes = { "nix" }

return {
  {
    "nvim-treesitter/nvim-treesitter",
    ft = filetypes,
    opts = { ensure_installed = { "nix" } },
  },

  {
    "mason-org/mason.nvim",
    ft = filetypes,
    opts = {
      ensure_installed = {
        "alejandra",
        "nil",
        "nixfmt",
        "nixpkgs-fmt",
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources, {
        null_ls.builtins.formatting.alejandra,
        null_ls.builtins.formatting.nixfmt,
        null_ls.builtins.formatting.nixpkgs_fmt,
        null_ls.builtins.formatting.nix_flake_fmt,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = filetypes,
    opts = {
      servers = {
        nil_ls = {},
      },
    },
  },
}

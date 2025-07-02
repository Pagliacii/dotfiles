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
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.alejandra,
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

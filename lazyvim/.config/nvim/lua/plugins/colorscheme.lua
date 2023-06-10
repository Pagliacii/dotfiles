return {
  {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      background = {
        light = "latte",
        dark = "frappe",
      },
      term_colors = true,
      -- color_overrides = {
      --   mocha = {
      --     base = "#000000",
      --     mantle = "#000000",
      --     crust = "#000000",
      --   },
      -- },
    },
  },

  { "EdenEast/nightfox.nvim", enabled = false },

  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = "#86abdc"
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
}

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = "#86abdc"
      end,
      on_highlights = function(highlights, colors)
        highlights.ColorColumn = { bg = colors.bg_highlight }
      end,
    },
  },

  {
    "sainnhe/gruvbox-material",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      -- Set contrast.
      vim.g.gruvbox_material_background = "medium"
      -- For better performance
      vim.g.gruvbox_material_better_performance = true
    end,
  },

  {
    "rose-pine/neovim",
    cond = false,
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        dark_variant = "moon",
      })
    end,
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = true,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}

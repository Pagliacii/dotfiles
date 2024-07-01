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
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      -- Set contrast.
      vim.g.gruvbox_material_background = "soft"
      -- For better performance
      vim.g.gruvbox_material_better_performance = true
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}

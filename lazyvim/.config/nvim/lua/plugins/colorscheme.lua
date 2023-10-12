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
    "stevedylandev/flexoki-nvim",
    name = "flexoki",
    enabled = false,
  },

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "flexoki",
  --   },
  -- },
}

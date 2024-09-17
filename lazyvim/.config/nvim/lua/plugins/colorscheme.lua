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
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        aerial = true,
        colorful_winsep = {
          enabled = true,
          color = "red",
        },
        diffview = true,
        dropbar = {
          enabled = true,
          color_mode = true,
        },
        harpoon = true,
        lsp_saga = true,
        mason = true,
        neotree = true,
        neotest = true,
        noice = true,
        navic = {
          enabled = true,
        },
        notify = true,
        nvim_surround = true,
        window_picker = true,
        octo = true,
        overseer = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        lsp_trouble = true,
        dadbod_ui = true,
        which_key = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}

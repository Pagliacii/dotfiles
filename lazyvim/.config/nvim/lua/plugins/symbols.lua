return {
  {
    "xiyaowong/telescope-emoji.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("emoji")
    end,
    keys = {
      { "<leader>tE", "<cmd>Telescope emoji theme=ivy<cr>", desc = "Emoji", noremap = true },
    },
  },

  {
    "ghassan0/telescope-glyph.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("glyph")
    end,
    keys = {
      { "<leader>tG", "<cmd>Telescope glyph theme=dropdown<cr>", desc = "Glyph", noremap = true },
    },
  },

  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>ts", "<cmd>Telescope symbols theme=dropdown<cr>", desc = "Symbols", noremap = true },
    },
  },

  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    cmd = "Nerdy",
    keys = {
      { "<leader>tN", "<cmd>Nerdy<cr>", desc = "NF glyphs", noremap = true },
    },
  },
}

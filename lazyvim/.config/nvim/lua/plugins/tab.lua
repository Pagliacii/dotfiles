return {
  {
    "LukasPietzschmann/telescope-tabs",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function(_, opts)
      require("telescope-tabs").setup(opts)
    end,
    opts = {
      show_preview = false,
    },
    keys = {
      { "<leader><tab>,", "<cmd>Telescope telescope-tabs list_tabs theme=dropdown<cr>", desc = "Tabs", noremap = true },
    },
  },
}

return {
  {
    "cshuaimin/ssr.nvim",
    name = "ssr",
    keys = {
      {
        "<leader>S",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural search and replace",
        noremap = true,
      },
    },
  },

  {
    "lalitmee/browse.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      bookmarks = {
        ["github"] = {
          ["name"] = "search github from neovim",
          ["code_search"] = "https://github.com/search?q=%s&type=code",
          ["repo_search"] = "https://github.com/search?q=%s&type=repositories",
          ["issues_search"] = "https://github.com/search?q=%s&type=issues",
          ["pulls_search"] = "https://github.com/search?q=%s&type=pullrequests",
        },
      },
    },
    keys = {
      { "<leader>BB", [[<cmd>lua require("browse").browse()<cr>]], desc = "Browse", noremap = true, silent = true },
      {
        "<leader>Bb",
        [[<cmd>lua require("browse").open_bookmarks()<cr>]],
        desc = "Bookmarks",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Bs",
        [[<cmd>lua require("browse").input_search()<cr>]],
        desc = "Search",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Bd",
        [[<cmd>lua require("browse.devdocs").search()<cr>]],
        desc = "Search devdocs",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Bf",
        [[<cmd>lua require("browse.devdocs").search_with_filetype()<cr>]],
        desc = "Search devdocs (ft)",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Bm",
        [[<cmd>lua require("browse.mdn").search()<cr>]],
        desc = "Search MDN",
        noremap = true,
        silent = true,
      },
    },
  },
}

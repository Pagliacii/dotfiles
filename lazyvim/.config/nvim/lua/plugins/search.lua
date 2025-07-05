return {
  {
    "cshuaimin/ssr.nvim",
    name = "ssr",
    keys = {
      {
        "<leader>se",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Search and replace",
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
        desc = "Search bookmarks",
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

  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
    config = function()
      require("telescope").load_extension("luasnip")
    end,
    keys = {
      { "<leader>tS", "<cmd>Telescope luasnip theme=ivy<cr>", desc = "Snippets", noremap = true },
    },
  },

  {
    "LinArcX/telescope-env.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("env")
    end,
    keys = {
      { "<leader>tv", "<cmd>Telescope env<cr>", desc = "Env variables", noremap = true },
    },
  },

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") },
    },
    config = function()
      require("neoclip").setup()
      require("telescope").load_extension("neoclip")
    end,
    keys = {
      { "<leader>tQ", "<cmd>Telescope macroscope<cr>", desc = "Macros", noremap = true },
    },
  },

  {
    "Marskey/telescope-sg",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("ast_grep")
    end,
    keys = {
      { "<leader>ta", "<cmd>Telescope ast_grep<cr>", desc = "AST grep", noremap = true },
    },
  },

  {
    "fdschmidt93/telescope-egrepify.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("egrepify")
    end,
    keys = {
      { "<leader>te", "<cmd>Telescope egrepify<cr>", desc = "Enhances live grep", noremap = true },
    },
  },
}

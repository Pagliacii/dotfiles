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

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      {
        "<leader>fB",
        "<cmd>Telescope file_browser<cr>",
        desc = "File browser",
        noremap = true,
      },
      {
        "<leader>f.",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "File browser (cwd)",
        noremap = true,
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
    "LinArcX/telescope-scriptnames.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("scriptnames")
    end,
    keys = {
      { "<leader>tA", "<cmd>Telescope scriptnames<cr>", desc = "Scriptnames", noremap = true },
    },
  },

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("neoclip").setup()
      require("telescope").load_extension("neoclip")
    end,
    keys = {
      { "<leader>tQ", "<cmd>Telescope macroscope<cr>", desc = "Macros", noremap = true },
      { "<leader>ty", "<cmd>Telescope neoclip theme=dropdown<cr>", desc = "Yanks", noremap = true },
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
}

return {
  {
    "klen/nvim-config-local",
    event = "VimEnter",
    opts = {
      -- Config file patterns to load (lua supported)
      config_files = { ".nvim.lua", ".nvimrc", ".exrc", ".vimrc.lua" },
      -- Where the plugin keeps files data
      hashfile = vim.fn.stdpath("data") .. "/config-local",
    },
  },

  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("telescope").load_extension("project")
    end,
    keys = {
      { "<leader>tp", "<cmd>Telescope project theme=dropdown<cr>", desc = "Projects", noremap = true },
    },
  },

  {
    "olimorris/persisted.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function(_, opts)
      require("persisted").setup(opts)
      require("telescope").load_extension("persisted")
    end,
    opts = {
      should_autosave = function()
        -- do not autosave if the alpha dashboard is the current filetype
        return vim.bo.filetype ~= "alpha"
      end,
      use_git_branch = true,
    },
    keys = {
      { "<leader>tq", "<cmd>Telescope persisted theme=dropdown<cr>", desc = "Sessions", noremap = true },
    },
  },
}

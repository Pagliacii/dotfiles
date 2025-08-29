return {
  {
    "chrisgrieser/nvim-genghis",
    cmd = "Genghis",
    opts = {
      navigation = {
        ignoreDotfiles = false,
      },
    },
    keys = function(_, keys)
      local cmd_factory = function(cmd)
        return string.format("<cmd>lua require('genghis').%s()<cr>", cmd)
      end

      vim.list_extend(keys, {
        { "<leader>f1", cmd_factory("copyFilename"), desc = "Copy filename", noremap = true },
        { "<leader>f2", cmd_factory("copyFilepath"), desc = "Copy abspath", noremap = true },
        { "<leader>f3", cmd_factory("copyFilepathWithTilde"), desc = "Copy abspath with ~", noremap = true },
        { "<leader>f4", cmd_factory("copyRelativePath"), desc = "Copy relpath", noremap = true },
        { "<leader>f5", cmd_factory("copyDirectoryPath"), desc = "Copy dir abspath", noremap = true },
        { "<leader>f6", cmd_factory("copyRelativeDirectoryPath"), desc = "Copy dir relpath", noremap = true },
        { "<leader>fc", cmd_factory("createNewFile"), desc = "Create new file", noremap = true },
        { "<leader>fX", cmd_factory("chmodx"), desc = "Chmod", noremap = true },
        { "<leader>fv", cmd_factory("moveAndRenameFile"), desc = "Mv & Rn", noremap = true },
        { "<leader>fd", cmd_factory("duplicateFile"), desc = "Duplicate", noremap = true },
        { "<leader>fD", cmd_factory("trashFile"), desc = "Move to trash", noremap = true },
        {
          "<leader>fx",
          cmd_factory("moveSelectionToNewFile"),
          mode = "x",
          desc = "Move to new file",
          noremap = true,
        },
        {
          "<leader>f[",
          function()
            require("genghis").navigateToFileInFolder("prev")
          end,
          desc = "Prev file in folder",
          noremap = true,
          silent = true,
        },
        {
          "<leader>f]",
          function()
            require("genghis").navigateToFileInFolder("next")
          end,
          desc = "Next file in folder",
          noremap = true,
          silent = true,
        },
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = false,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    },
    cmd = { "Oil" },
    keys = {
      { "<leader>fO", "<cmd>Oil<cr>", desc = "Open parent directory", noremap = true },
      {
        "<leader>fo",
        function(...)
          require("oil").toggle_float(...)
        end,
        desc = "Open parent directory in float window",
        noremap = true,
      },
    },
  },

  {
    "kevinhwang91/nvim-fundo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost" },
    build = function()
      require("fundo").install()
    end,
    config = function(_, opts)
      vim.o.undofile = true
      require("fundo").setup(opts)
    end,
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("undo")
    end,
    keys = {
      { "<leader>tu", "<cmd>Telescope undo<cr>", desc = "Undo tree" },
    },
  },

  {
    "LinArcX/telescope-changes.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("changes")
    end,
    keys = {
      { "<leader>tc", "<cmd>Telescope changes<cr>", desc = "Changes", noremap = true },
    },
  },

  {
    "LintaoAmons/scratch.nvim",
    cmd = {
      "Scratch",
      "ScratchWithName",
      "ScratchOpen",
      "ScratchOpenFzf",
      "ScratchCheckConfig",
      "ScratchEditConfig",
      "ScratchPad",
    },
    keys = {
      { "<M-C-n>", "<cmd>Scratch<cr>", desc = "Scratch" },
      { "<M-C-o>", "<cmd>ScratchOpenFzf<cr>", desc = "ScratchOpenFzf" },
    },
  },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    cmd = { "Yazi" },
    keys = {
      { "<leader>f/", "<cmd>Yazi<cr>", desc = "Yazi (file)", noremap = true, silent = true },
      { "<leader>fw", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)", noremap = true, silent = true },
      { "<leader>fz", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", noremap = true, silent = true },
    },
    ---@type YaziConfig
    opts = {
      open_multiple_tabs = true,
      open_for_directories = true,
      yazi_floating_window_border = "none",
      floating_window_scaling_factor = 0.85,
    },
  },
}

return {
  {
    "chrisgrieser/nvim-genghis",
    dependencies = {
      "stevearc/dressing.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-omni",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup.filetype("DressingInput", {
        sources = cmp.config.sources({ { name = "omni" } }),
      })
    end,
    keys = function(_, keys)
      local cmd_factory = function(cmd)
        return string.format("<cmd>lua require('genghis').%s()<cr>", cmd)
      end

      vim.list_extend(keys, {
        { "<leader>fp", cmd_factory("copyFilepath"), desc = "Copy file path", noremap = true },
        { "<leader>fy", cmd_factory("copyFilename"), desc = "Copy file name", noremap = true },
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
      { "<leader>UO", "<cmd>Oil<cr>", desc = "Open parent directory", noremap = true },
      {
        "<leader>Uo",
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

  {
    "simonmclean/triptych.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = true,
    cmd = { "Triptych" },
    keys = {
      { "<leader>f/", "<cmd>Triptych<cr>", desc = "Directory Browser", noremap = true, silent = true },
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

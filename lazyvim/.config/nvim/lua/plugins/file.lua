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
        { "<leader>fm", cmd_factory("moveAndRenameFile"), desc = "Mv & Rn", noremap = true },
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
    "ThePrimeagen/harpoon",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function(_, opts)
      require("harpoon").setup(opts)
      require("telescope").load_extension("harpoon")
    end,
    opts = {
      excluded_filetypes = {
        "harpoon",
        "dap-repl",
        "dap-float",
        "dap-terminal",
        "terminal",
        "toggleterm",
        "alpha",
        "dashboard",
      },
    },
    keys = {
      { "<leader>tm", "<cmd>Telescope harpoon marks<cr>", desc = "Marks", noremap = true },
      { "<leader>f;", "<cmd>lua require('harpoon.mark').toggle_file()<cr>", desc = "Toggle mark", noremap = true },
      { "<leader>ft", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Quick menu", noremap = true },
      { "<leader>fk", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Prev mark", noremap = true },
      { "<leader>fj", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Next mark", noremap = true },
    },
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = false,
    },
    cmd = { "Oil" },
    keys = {
      { "<leader>Uo", "<cmd>Oil<cr>", desc = "Oil", noremap = true },
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
    event = "VeryLazy",
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
}

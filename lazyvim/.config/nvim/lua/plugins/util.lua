return {
  {
    "christoomey/vim-tmux-navigator",
    keys = function(_, keys)
      if vim.fn.executable("tmux") == 1 then
        vim.list_extend(keys, {
          { "<C-h>", "<cmd> TmuxNavigateLeft<cr>",  desc = "Window left" },
          { "<C-l>", "<cmd> TmuxNavigateRight<cr>", desc = "Window right" },
          { "<C-j>", "<cmd> TmuxNavigateDown<cr>",  desc = "Window down" },
          { "<C-k>", "<cmd> TmuxNavigateUp<cr>",    desc = "Window up" },
        })
      end
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd> DiffviewOpen<cr>", desc = "Open Diffview" },
    },
  },

  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },

  {
    "lewis6991/hover.nvim",
    opts = {
      init = function()
        require("hover.providers.dictionary")
      end
    },
    keys = {
      { "<leader>yd", function() require("hover").hover() end, desc = "Lookup word under cursor in dictionary" }
    }
  },

  {
    "voldikss/vim-translator",
    keys = {
      { "<leader>yw", "<cmd>TranslateW<cr>", mode = { "n", "v" }, desc = "Display translation in window" },
    }
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false, max_join_length = 150 },
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join toggle" },
    },
  },

  {
    "monaqa/dial.nvim",
    -- lazy-load on keys
    -- mode is `n` by default. For more advanced options, check the section on key mappings
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  {
    "ziontee113/icon-picker.nvim",
    opts = {
      disable_legacy_commands = true,
    },
    keys = {
      {
        "<leader>pin",
        "<cmd>IconPickerNormal nerd_font<cr>",
        desc = "Pick nerd_font",
        noremap = true,
        silent = true
      },
      {
        "<leader>pie",
        "<cmd>IconPickerNormal emoji<cr>",
        desc = "Pick emoji",
        noremap = true,
        silent = true
      },
      {
        "<leader>pih",
        "<cmd>IconPickerNormal html_colors<cr>",
        desc = "Pick html_colors",
        noremap = true,
        silent = true
      },
      {
        "<leader>pis",
        "<cmd>IconPickerNormal symbols<cr>",
        desc = "Pick symbols",
        noremap = true,
        silent = true
      },
      {
        "<leader>piy",
        "<cmd>IconPickerYank nerd_font emoji symbols html_colors<cr>",
        desc = "Yank icon",
        noremap = true,
        silent = true
      },
    },
  },
}

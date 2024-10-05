return {
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommanded to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frequency sorting
    -- dependencies = { "kkharji/sqlite.lua" },
    opts = {
      extensions = {
        lazy_nvim = true,
        which_key = {
          auto_register = true,
        },
        smart_splits = {
          directions = { "h", "j", "k", "l" },
          mods = {
            move = "<C>",
            resize = "<M>",
          },
        },
        diffview = true,
      },
    },
    keys = {
      { "<leader>\\", "<cmd>Legendary<cr>", desc = "Open Legendary", noremap = true, silent = true },
    },
  },

  --- Establish good command workflow and quit bad habit.
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    cmd = "Hardtime",
    opts = {
      notification = true,
      --- If you want to see the hint messages in insert and visual mode, set the 'showmode' to false.
      showmode = true,
    },
  },
}

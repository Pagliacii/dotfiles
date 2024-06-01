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
        smart_splits = true,
        diffview = true,
      },
    },
  },
}

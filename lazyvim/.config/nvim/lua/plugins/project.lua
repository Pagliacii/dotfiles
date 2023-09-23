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
}

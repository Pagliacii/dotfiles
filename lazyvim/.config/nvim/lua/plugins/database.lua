return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
    keys = {
      {
        "<leader>vc",
        function()
          local url = vim.fn.input("DB URL: ")
          if #url > 0 then
            vim.cmd(string.format("DB %s", url))
          end
        end,
        desc = "DB connect",
      },
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>vu", "<cmd>DBUI<cr>", desc = "Open DBUI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}

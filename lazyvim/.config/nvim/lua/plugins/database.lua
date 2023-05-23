return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
    keys = {
      {
        "<leader>Tc",
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
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI" },
    keys = {
      { "<leader>Tu", "<cmd>DBUI<cr>", desc = "Open DBUI" },
    },
  },
}

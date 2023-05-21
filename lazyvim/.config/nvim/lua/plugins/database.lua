return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
    keys = {
      {
        "<leader>Dc",
        function()
          local url = vim.fn.input("DB URL: ")
          if #url > 0 then
            vim.cmd(string.format("DB %s", url))
          end
        end,
        desc = "Connect",
      },
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI" },
    keys = {
      { "<leader>Du", "<cmd>DBUI<cr>", desc = "Open DBUI" },
    },
  },
}

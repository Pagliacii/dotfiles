return {
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      snippetDir = vim.uv.os_homedir() .. "/snippets",
      jsonFormatter = "jq",
    },
    keys = {
      {
        "<leader>Sa",
        function()
          require("scissors").addNewSnippet()
        end,
        mode = { "n", "v" },
        desc = "Add new snippet",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Se",
        function()
          require("scissors").editSnippet()
        end,
        desc = "Edit snippets",
        noremap = true,
        silent = true,
      },
    },
  },
}

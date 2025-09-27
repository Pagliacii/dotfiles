local filetypes = { "http", "rest" }
local prefix = "<leader>ph"

return {
  "mistweaverco/kulala.nvim",
  ft = filetypes,
  keys = {
    -- Programming group REST keybindings
    { "<leader>R", false }, -- unmap default LazyVim keybinding
    { prefix .. "b", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad", ft = "http" },
    { prefix .. "c", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = "http" },
    { prefix .. "C", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
    {
      prefix .. "g",
      "<cmd>lua require('kulala').download_graphql_schema()<cr>",
      desc = "Download GraphQL schema",
      ft = "http",
    },
    { prefix .. "i", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request", ft = "http" },
    { prefix .. "n", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http" },
    { prefix .. "p", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request", ft = "http" },
    { prefix .. "q", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", ft = "http" },
    { prefix .. "r", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request", ft = "http" },
    { prefix .. "s", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = "http" },
    { prefix .. "S", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", ft = "http" },
    { prefix .. "t", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body", ft = "http" },
  },
}

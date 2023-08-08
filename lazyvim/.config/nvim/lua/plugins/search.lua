return {
  {
    "cshuaimin/ssr.nvim",
    name = "ssr",
    keys = {
      {
        "<leader>S",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural search and replace",
        noremap = true,
      },
    },
  },
}

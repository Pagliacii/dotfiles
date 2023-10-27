return {
  {
    "chrisgrieser/nvim-rulebook",
    keys = {
      {
        "<leader>cI",
        function()
          require("rulebook").ignoreRule()
        end,
        desc = "Ignore rule",
      },
      {
        "<leader>cL",
        function()
          require("rulebook").lookupRule()
        end,
        desc = "Lookup rule",
      },
    },
  },
}

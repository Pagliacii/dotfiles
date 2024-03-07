return {
  {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>Ad",
        function()
          require("duck").hatch()
        end,
        desc = "Duck",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Aa",
        function()
          require("duck").hatch("ඞ")
        end,
        desc = "Among us",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Ac",
        function()
          require("duck").hatch("🦀")
        end,
        desc = "Crab",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Ak",
        function()
          require("duck").hatch("🐈", 0.75)
        end,
        desc = "Kitty",
        noremap = true,
        silent = true,
      },
      {
        "<leader>A1",
        function()
          require("duck").hatch("🐎", 10)
        end,
        desc = "Horse",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Ab",
        function()
          require("duck").hatch("🦖")
        end,
        desc = "T-rex",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Aj",
        function()
          require("duck").hatch("🐤")
        end,
        desc = "Chicken",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Ag",
        function()
          require("duck").hatch("👻")
        end,
        desc = "Ghost",
        noremap = true,
        silent = true,
      },
      {
        "<leader>A8",
        function()
          require("duck").hatch("🎱")
        end,
        desc = "Ghost",
        noremap = true,
        silent = true,
      },
      {
        "<leader>Az",
        function()
          require("duck").hatch("🀄")
        end,
        desc = "Mahjong",
        noremap = true,
        silent = true,
      },
      {
        "<leader>AC",
        function()
          require("duck").cook()
        end,
        desc = "Cook",
        noremap = true,
        silent = true,
      },
      {
        "<leader>AA",
        function()
          require("duck").cook_all()
        end,
        desc = "Cook all",
        noremap = true,
        silent = true,
      },
    },
  },
}

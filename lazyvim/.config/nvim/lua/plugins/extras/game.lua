return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = { "CellularAutomaton" },
  },

  {
    "seandewar/nvimesweeper",
    cmd = { "Nvimesweeper" },
  },

  {
    "jim-fx/sudoku.nvim",
    config = true,
    cmd = { "Sudoku" },
  },

  {
    "rktjmp/shenzhen-solitaire.nvim",
    cmd = { "ShenzhenSolitaireNewGame", "ShenzhenSolitaireNextGame" },
  },

  {
    "NStefan002/speedtyper.nvim",
    branch = "main",
    cmd = "Speedtyper",
    opts = {
      game_modes = {
        countdown = { time = 60 },
      },
    },
  },

  {
    "NStefan002/2048.nvim",
    cmd = "Play2048",
    config = true,
  },
}

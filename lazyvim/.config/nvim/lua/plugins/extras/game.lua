return {
  {
    "eandrju/cellular-automaton.nvim",
    config = function()
      local config = {
        fps = 50,
        name = "slide",
      }

      -- init function is invoked only once at the start
      -- config.init = function (grid)
      --
      -- end

      -- update function
      config.update = function(grid)
        for i = 1, #grid do
          local prev = grid[i][#grid[i]]
          for j = 1, #grid[i] do
            grid[i][j], prev = prev, grid[i][j]
          end
        end
        return true
      end

      require("cellular-automaton").register_animation(config)
    end,
    cmd = { "CellularAutomaton" },
    keys = {
      { "<leader>Ar", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain", noremap = true, silent = true },
      { "<leader>Al", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Game of life", noremap = true, silent = true },
      { "<leader>AS", "<cmd>CellularAutomaton slide<cr>", desc = "Slide", noremap = true, silent = true },
    },
  },

  {
    "seandewar/nvimesweeper",
    cmd = { "Nvimesweeper" },
    keys = {
      { "<leader>Am", "<cmd>Nvimesweeper<cr>", desc = "Nvimesweeper", noremap = true, silent = true },
    },
  },

  {
    "jim-fx/sudoku.nvim",
    config = true,
    cmd = { "Sudoku" },
    keys = {
      { "<leader>As", "<cmd>Sudoku<cr>", desc = "Sudoku", noremap = true, silent = true },
    },
  },

  {
    "rktjmp/shenzhen-solitaire.nvim",
    cmd = { "ShenzhenSolitaireNewGame", "ShenzhenSolitaireNextGame" },
    keys = {
      {
        "<leader>Ah",
        "<cmd>ShenzhenSolitaireNewGame<cr>",
        desc = "ShenzhenSolitaireNewGame",
        noremap = true,
        silent = true,
      },
      {
        "<leader>AH",
        "<cmd>ShenzhenSolitaireNextGame<cr>",
        desc = "ShenzhenSolitaireNextGame",
        noremap = true,
        silent = true,
      },
    },
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
    keys = {
      { "<leader>At", "<cmd>Speedtyper<cr>", desc = "Speedtyper", noremap = true, silent = true },
    },
  },

  {
    "NStefan002/2048.nvim",
    cmd = "Play2048",
    config = true,
    keys = {
      { "<leader>A2", "<cmd>Play2048<cr>", desc = "Play 2048", noremap = true, silent = true },
    },
  },
}

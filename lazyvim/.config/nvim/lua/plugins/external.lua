return {
  {
    "willothy/wezterm.nvim",
    config = true,
    cmd = { "WeztermSpawn" },
    keys = {
      {
        "<leader>Wp",
        function()
          require("wezterm").switch_tab.relative(-1)
        end,
        desc = "Prev tab",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wn",
        function()
          require("wezterm").switch_tab.relative(1)
        end,
        desc = "Next tab",
        silent = true,
        noremap = true,
      },
      {
        "<leader>W-",
        function()
          require("wezterm").split_pane.vertical()
        end,
        desc = "Split pane below",
        silent = true,
        noremap = true,
      },
      {
        "<leader>W|",
        function()
          require("wezterm").split_pane.horizontal()
        end,
        desc = "Split pane right",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wj",
        function()
          require("wezterm").switch_pane.direction("Down")
        end,
        desc = "Switch to down pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wk",
        function()
          require("wezterm").switch_pane.direction("Up")
        end,
        desc = "Switch to up pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wh",
        function()
          require("wezterm").switch_pane.direction("Left")
        end,
        desc = "Switch to left pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>Wl",
        function()
          require("wezterm").switch_pane.direction("Right")
        end,
        desc = "Switch to right pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>WP",
        function()
          require("wezterm").switch_pane.direction("Prev")
        end,
        desc = "Switch to previous pane",
        silent = true,
        noremap = true,
      },
      {
        "<leader>WN",
        function()
          require("wezterm").switch_pane.direction("Next")
        end,
        desc = "Switch to next pane",
        silent = true,
        noremap = true,
      },
    },
  },
}

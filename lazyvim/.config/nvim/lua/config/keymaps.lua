-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

-- Groups
wk.register({
  ["<leader>r"] = { name = "+rust" },
  ["<leader>P"] = {
    name = "+picker",
    i = { name = "+icon" },
  },
  ["<leader>M"] = { name = "+markdown" },
  ["<leader>N"] = {
    name = "+note",
    c = { name = "+cwd" },
    g = { name = "+global" },
    l = { name = "+line" },
    j = { name = "+jump" },
    C = { name = "+count" },
    E = { name = "+export" },
    I = { name = "+import" },
    L = { name = "+list" },
  },
  ["<leader>G"] = { name = "+go" },
  ["<leader>du"] = { name = "+ui" },
  ["<leader>U"] = {
    name = "+util",
    mode = { "n", "v" },
  },
  ["<leader>t"] = { name = "+telescope" },
  ["gz"] = "which_key_ignore",
})

-- Unset LazyVim's default bindings
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

if vim.fn.executable("gitui") == 1 then
  wk.register({
    ["<leader>gu"] = {
      name = "+gitui",
      G = {
        function()
          require("lazyvim.util").float_term({ "gitui" })
        end,
        "gitui (cwd)",
      },
      g = {
        function()
          require("lazyvim.util").float_term({ "gitui" }, { cwd = require("lazyvim.util").get_root() })
        end,
        "gitui (root dir)",
      },
    },
  })
end

if vim.fn.executable("verco") == 1 then
  wk.register({
    ["<leader>gv"] = {
      name = "+verco",
      G = {
        function()
          require("lazyvim.util").float_term({ "verco" })
        end,
        "verco (cwd)",
      },
      g = {
        function()
          require("lazyvim.util").float_term({ "verco" }, { cwd = require("lazyvim.util").get_root() })
        end,
        "verco (root dir)",
      },
    },
  })
end

if vim.fn.executable("btop") == 1 then
  -- btop
  vim.keymap.set("n", "<leader>Ub", function()
    require("lazyvim.util").float_term({ "btop" })
  end, { desc = "btop" })
end

vim.keymap.set("n", "<leader>a", "<cmd> lua require('alpha').start(false)<cr>", { desc = "Open Dashboard" })

-- Keey your register clean from `dd`
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })

return {
  {
    "rcarriga/nvim-dap-ui",
    keys = {
      {
        "<leader>dui",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle UI",
      },
    },
  },

  {
    "LiadOz/nvim-dap-repl-highlights",
    config = true,
    ft = { "dap-repl" },
  },

  {
    "mfussenegger/nvim-dap",
    opts = function()
      -- string parser with quote escaping capabilities
      -- inspired by http://lua-users.org/wiki/LpegRecipes
      --- @param input string
      --- @return table
      local function split(input)
        local lpeg = vim.lpeg
        local P, S, C, Cc, Ct = lpeg.P, lpeg.S, lpeg.C, lpeg.Cc, lpeg.Ct

        --- @param id string
        --- @param patt vim.lpeg.Capture
        --- @return vim.lpeg.Pattern
        local function token(id, patt)
          return Ct(Cc(id) * C(patt))
        end

        local single_quoted = P("'") * ((1 - S("'\r\n\f\\")) + (P("\\") * 1)) ^ 0 * "'"
        local double_quoted = P('"') * ((1 - S('"\r\n\f\\')) + (P("\\") * 1)) ^ 0 * '"'
        local whitespace = token("whitespace", S("\r\n\f\t ") ^ 1)
        local word = token("word", (1 - S("' \r\n\f\t\"")) ^ 1)
        local string = token("string", single_quoted + double_quoted)
        local pattern = Ct((string + whitespace + word) ^ 0)

        local t = {}
        local tokens = lpeg.match(pattern, input)

        -- somehow, this did not work out
        if tokens == nil or type(tokens) == "integer" then
          return t
        end

        for _, tok in ipairs(tokens) do
          if tok[1] ~= "whitespace" then
            if tok[1] == "string" then
              -- cut off quotes and replace escaped quotes
              table.insert(t, tok[2]:sub(2, -2):gsub("\\(['\"])", "%1"))
            else
              table.insert(t, tok[2])
            end
          end
        end

        return t
      end

      local dap = require("dap")
      dap.listeners.on_config["cpp"] = function(config)
        if config.type ~= "codelldb" then
          return config
        end

        -- copy the config and split the args if it is a string
        local c = {}

        for k, v in pairs(vim.deepcopy(config)) do
          if k == "args" and type(v) == "string" then
            c[k] = split(v)
          else
            c[k] = v
          end
        end

        return c
      end
    end,
    keys = {
      { "<leader>dO", false },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>", desc = "Next", noremap = true },
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb", "debugpy", "delve" })
    end,
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("dap")
    end,
    keys = {
      { "<leader>d1", "<cmd> Telescope dap commands theme=dropdown<cr>", desc = "Commands" },
      { "<leader>d2", "<cmd> Telescope dap frames<cr>", desc = "Frames" },
      { "<leader>d3", "<cmd> Telescope dap list_breakpoints<cr>", desc = "Breakpoints" },
      { "<leader>d4", "<cmd> Telescope dap configurations theme=dropdown<cr>", desc = "Configurations" },
      { "<leader>d5", "<cmd> Telescope dap variables<cr>", desc = "Variables" },
    },
  },

  {
    "chrisgrieser/nvim-chainsaw",
    opts = {},
    keys = {
      {
        "<leader>dLm",
        function()
          require("chainsaw").messageLog()
        end,
        desc = "Message",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLv",
        function()
          require("chainsaw").variableLog()
        end,
        mode = { "n", "v" },
        desc = "Variable",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLo",
        function()
          require("chainsaw").objectLog()
        end,
        desc = "Object",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLa",
        function()
          require("chainsaw").assertLog()
        end,
        desc = "Assert",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLb",
        function()
          require("chainsaw").beepLog()
        end,
        desc = "Beep",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLt",
        function()
          require("chainsaw").timeLog()
        end,
        desc = "Time",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLd",
        function()
          require("chainsaw").debugLog()
        end,
        desc = "Debug",
        noremap = true,
        silent = true,
      },
      {
        "<leader>dLr",
        function()
          require("chainsaw").removeLogs()
        end,
        desc = "Remove",
        noremap = true,
        silent = true,
      },
    },
  },

  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("timber").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}

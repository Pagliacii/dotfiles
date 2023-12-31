return {
  {
    "rcarriga/cmp-dap",
    ft = { "dap-repl", "dapui_watches", "dapui_hover" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      })
      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
    keys = function(_, keys)
      ---Toggle dap sidebar
      ---@param name string
      ---@return function
      local function toggle_sidebar(name)
        return function(...)
          local widgets = require("dap.ui.widgets")
          local sidebar = widgets.sidebar(widgets[name], { width = 40 })
          local is_opened = false
          if is_opened then
            sidebar.close(...)
          else
            sidebar.open(...)
            vim.api.nvim_buf_set_option(sidebar.buf, "filetype", "dap-sidebar")
          end
        end
      end
      vim.list_extend(keys, {
        { "<leader>dus", toggle_sidebar("scopes"), desc = "Scopes", noremap = true },
        { "<leader>duf", toggle_sidebar("frames"), desc = "Frames", noremap = true },
        { "<leader>duS", toggle_sidebar("sessions"), desc = "Sessions", noremap = true },
        { "<leader>dut", toggle_sidebar("threads"), desc = "Threads", noremap = true },
        { "<leader>due", toggle_sidebar("expression"), desc = "Expression", noremap = true },
      })
      return keys
    end,
  },

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
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    ft = { "dap-repl" },
  },

  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dO", false },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>", desc = "Next", noremap = true },
    },
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
}

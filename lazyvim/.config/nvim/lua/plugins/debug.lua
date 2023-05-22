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
        local widgets = require("dap.ui.widgets")
        local sidebar = widgets.sidebar(widgets[name], { width = 40 })
        local is_opened = false
        return function(...)
          if is_opened then
            sidebar.close(...)
          else
            sidebar.open(...)
            vim.api.nvim_buf_set_option(sidebar.buf, "filetype", "dap-sidebar")
          end
        end
      end
      vim.list_extend(keys, {
        { "<leader>dus", toggle_sidebar("scopes"),     desc = "Scopes",     noremap = true },
        { "<leader>duf", toggle_sidebar("frames"),     desc = "Frames",     noremap = true },
        { "<leader>duS", toggle_sidebar("sessions"),   desc = "Sessions",   noremap = true },
        { "<leader>dut", toggle_sidebar("threads"),    desc = "Threads",    noremap = true },
        { "<leader>due", toggle_sidebar("expression"), desc = "Expression", noremap = true },
      })
      return keys
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      dapui.setup(opts)
    end,
    keys = {
      {
        "<leader>duu",
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
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          opts.highlight = { enable = true }
          table.insert(opts.ensure_installed, "dap_repl")
        end,
      },
    },
    config = true,
    ft = { "dap-repl" },
  },
}

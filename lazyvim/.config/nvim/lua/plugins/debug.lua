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
      { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
    },
  },
}

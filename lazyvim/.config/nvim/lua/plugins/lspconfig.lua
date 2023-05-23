local formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
          "nvim-telescope/telescope.nvim",
        },
        opts = { lsp = { auto_attach = true } },
        cmd = { "Navbuddy" },
        keys = {
          { "gb", "<cmd>Navbuddy<cr>", desc = "Open Nav[b]uddy", noremap = true },
        },
      },
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      diagnostics = {
        update_in_insert = true,
      },
      format = {
        timeout_ms = 10000,
      },
      servers = {},
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = {
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = formatting_group,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = formatting_group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 10000 })
            end,
          })
        end
      end,
    },
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
      symbol_in_winbar = {
        show_file = false,
      },
    },
    keys = function(_, keys)
      local wk = require("which-key")
      wk.register({
        ["<leader>D"] = { name = "+diagnostics" },
      })
      local cmd = function(name, ...)
        local cmd_str = string.format("<cmd>Lspsaga %s", name)
        local args = { ... }
        for _, v in ipairs(args) do
          cmd_str = string.format("%s %s", cmd_str, v)
        end
        return cmd_str .. "<cr>"
      end
      vim.list_extend(keys, {
        { "gh", cmd("lsp_finder"), desc = "Lsp finder", noremap = true },
        {
          "<leader>ca",
          cmd("code_action"),
          mode = { "n", "v" },
          desc = "Code action",
          noremap = true,
        },
        { "<leader>cr", cmd("rename", "++project"), desc = "Rename (project)", noremap = true },
        { "<leader>cR", cmd("rename"), desc = "Rename (file)", noremap = true },
        { "<leader>co", cmd("outline"), desc = "Toggle outline", noremap = true },
        { "K", cmd("hover_doc"), desc = "Hover doc", noremap = true },
        { "<leader>k", cmd("hover_doc", "++keep"), desc = "Hover doc (keep)", noremap = true },
        { "<leader>cI", cmd("incoming_calls"), desc = "Incoming calls", noremap = true },
        { "<leader>cO", cmd("outgoing_calls"), desc = "Outgoing calls", noremap = true },
        ---diagnostics
        { "<leader>Dc", cmd("show_cursor_diagnostics"), desc = "Cursor diagnostics", noremap = true },
        { "<leader>Dl", cmd("show_line_diagnostics"), desc = "Line diagnostics", noremap = true },
        { "<leader>Db", cmd("show_buf_diagnostics"), desc = "Buffer diagnostics", noremap = true },
        { "<leader>Dw", cmd("show_workspace_diagnostics"), desc = "Workspace diagnostics", noremap = true },
        { "[d", cmd("diagnostics_jump_prev"), desc = "Prev diagnostics", noremap = true },
        { "]d", cmd("diagnostics_jump_next"), desc = "Next diagnostics", noremap = true },
        {
          "[e",
          function()
            require("lspsaga.diagnostics"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end,
          desc = "Prev error",
          noremap = true,
        },
        {
          "]e",
          function()
            require("lspsaga.diagnostics"):goto_next({ severity = vim.diagnostic.severity.ERROR })
          end,
          desc = "Next error",
          noremap = true,
        },
        ---goto
        { "gd", cmd("goto_definition"), desc = "Goto definition", noremap = true },
        { "gt", cmd("goto_type_definition"), desc = "Goto type definition", noremap = true },
        { "gy", false },
        ---peek
        { "gpd", cmd("peek_definition"), desc = "Peek definition", noremap = true },
        { "gpt", cmd("peek_type_definition"), desc = "Peek type definition", noremap = true },
      })
      return keys
    end,
  },
}

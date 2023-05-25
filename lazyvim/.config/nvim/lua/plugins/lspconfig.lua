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
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      symbol_in_winbar = {
        show_file = false,
      },
    },
    keys = function(_, keys)
      local wk = require("which-key")
      wk.register({
        ["<leader>k"] = { name = "+lspsaga" },
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
          "<leader>ka",
          cmd("code_action"),
          mode = { "n", "v" },
          desc = "Code action",
          noremap = true,
        },
        {
          "<leader>kr",
          cmd("rename", "++project"),
          desc = "Rename (project)",
          noremap = true,
        },
        { "<leader>kR", cmd("rename"), desc = "Rename (file)", noremap = true },
        { "<leader>ko", cmd("outline"), desc = "Toggle outline", noremap = true },
        { "<leader>kh", cmd("hover_doc"), desc = "Hover doc", noremap = true },
        { "<leader>kk", cmd("hover_doc", "++keep"), desc = "Hover doc (keep)", noremap = true },
        { "<leader>kI", cmd("incoming_calls"), desc = "Incoming calls", noremap = true },
        { "<leader>kO", cmd("outgoing_calls"), desc = "Outgoing calls", noremap = true },
        ---diagnostics
        { "<leader>kc", cmd("show_cursor_diagnostics"), desc = "Cursor diagnostics", noremap = true },
        { "<leader>kl", cmd("show_line_diagnostics"), desc = "Line diagnostics", noremap = true },
        { "<leader>kb", cmd("show_buf_diagnostics"), desc = "Buffer diagnostics", noremap = true },
        { "<leader>kw", cmd("show_workspace_diagnostics"), desc = "Workspace diagnostics", noremap = true },
        { "<leader>k[", cmd("diagnostics_jump_prev"), desc = "Prev diagnostics", noremap = true },
        { "<leader>k]", cmd("diagnostics_jump_next"), desc = "Next diagnostics", noremap = true },
        {
          "<leader>kE",
          function()
            require("lspsaga.diagnostics"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end,
          desc = "Prev error",
          noremap = true,
        },
        {
          "<leader>ke",
          function()
            require("lspsaga.diagnostics"):goto_next({ severity = vim.diagnostic.severity.ERROR })
          end,
          desc = "Next error",
          noremap = true,
        },
        ---goto
        { "<leader>kd", cmd("goto_definition"), desc = "Goto definition", noremap = true },
        { "<leader>kt", cmd("goto_type_definition"), desc = "Goto type definition", noremap = true },
        ---peek
        { "<leader>kp", cmd("peek_definition"), desc = "Peek definition", noremap = true },
        { "<leader>ky", cmd("peek_type_definition"), desc = "Peek t[y]pe definition", noremap = true },
      })
      return keys
    end,
  },
}
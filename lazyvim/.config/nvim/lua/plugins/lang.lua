-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
local formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  {
    "neovim/nvim-lspconfig",
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

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "shellcheck",
        "shfmt",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = false },
      ensure_installed = {
        "json",
        "markdown",
        "markdown_inline",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
      },
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
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = function(_, keys)
      local wk = require("which-key")
      wk.register({
        ["<leader>L"] = {
          name = "Lspsaga",
          mode = { "n", "v" },
          d = { name = "+diagnostics" },
          g = { name = "+goto" },
          p = { name = "+peek" },
        },
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
        { "<leader>Lf", cmd("lsp_finder"), desc = "Lsp finder", noremap = true },
        { "<leader>La", cmd("code_action"), desc = "Code action", noremap = true },
        { "<leader>Lr", cmd("rename", "++project"), desc = "Code rename", noremap = true },
        { "<leader>Lo", cmd("outline"), desc = "Toggle outline", noremap = true },
        { "<leader>Lh", cmd("hover_doc"), desc = "Hover doc", noremap = true },
        { "<leader>Lk", cmd("hover_doc", "++keep"), desc = "Hover doc (keep)", noremap = true },
        { "<leader>LI", cmd("incoming_calls"), desc = "Incoming calls", noremap = true },
        { "<leader>LO", cmd("outgoing_calls"), desc = "Outgoing calls", noremap = true },
        ---diagnostics
        { "<leader>Ldc", cmd("show_cursor_diagnostics"), desc = "Cursor diagnostics", noremap = true },
        { "<leader>Ldl", cmd("show_line_diagnostics"), desc = "Line diagnostics", noremap = true },
        { "<leader>Ldb", cmd("show_buf_diagnostics"), desc = "Buffer diagnostics", noremap = true },
        { "<leader>Ldw", cmd("show_workspace_diagnostics"), desc = "Workspace diagnostics", noremap = true },
        { "<leader>Ldp", cmd("diagnostics_jump_prev"), desc = "Prev diagnostics", noremap = true },
        { "<leader>Ldn", cmd("diagnostics_jump_next"), desc = "Next diagnostics", noremap = true },
        {
          "<leader>Ld[",
          function()
            require("lspsaga.diagnostics"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end,
          desc = "Prev error",
          noremap = true,
        },
        {
          "<leader>Ld]",
          function()
            require("lspsaga.diagnostics"):goto_next({ severity = vim.diagnostic.severity.ERROR })
          end,
          desc = "Next error",
          noremap = true,
        },
        ---goto
        { "<leader>Lgd", cmd("goto_definition"), desc = "Goto definition", noremap = true },
        { "<leader>Lgt", cmd("goto_type_definition"), desc = "Goto type definition", noremap = true },
        ---peek
        { "<leader>Lpd", cmd("peek_definition"), desc = "Peek definition", noremap = true },
        { "<leader>Lpt", cmd("peek_type_definition"), desc = "Peek type definition", noremap = true },
      })
      return keys
    end,
  },

  -- Core language specific extension modules
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.dap.nlua" },

  -- Custom language specific extension modules
  { import = "plugins.extras.lang.golang" },
  { import = "plugins.extras.lang.python" },
  { import = "plugins.extras.lang.rust" },
  { import = "plugins.extras.lang.lua" },
}

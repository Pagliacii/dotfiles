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

  -- Core language specific extension modules
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.dap.nlua" },

  -- Custom language specific extension modules
  { import = "plugins.extras.lang.golang" },
  { import = "plugins.extras.lang.python" },
  { import = "plugins.extras.lang.rust" },
  { import = "plugins.extras.lang.lua" },
}

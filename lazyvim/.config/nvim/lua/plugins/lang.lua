-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
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
        timeout_ms = 5000,
      },
      servers = {},
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "json",
        "markdown",
        "markdown_inline",
        "regex",
        "selene",
        "stylua",
        "shellcheck",
        "shfmt",
        "vim",
        "yaml",
      },
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
}

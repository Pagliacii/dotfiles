-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash-language-server",
          "shellcheck",
          "shfmt",
        })
      end
    end,
  },

  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
  },

  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.dap.nlua" },

  -- Core language specific extension modules
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.cmake" },

  -- Custom language specific extension modules
  { import = "plugins.extras.lang.golang" },
  { import = "plugins.extras.lang.python" },
  { import = "plugins.extras.lang.rust" },
  { import = "plugins.extras.lang.lua" },
  { import = "plugins.extras.game" },
}

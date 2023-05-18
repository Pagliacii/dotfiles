return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "selene",
        "stylua",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "luadoc",
        "luap",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "lua" },
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.diagnostics.selene,
        require("null-ls").builtins.formatting.stylua,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "jit" },
                neededFileStatus = { "Opened" },
                groupFileStatus = { "Opened" },
                libraryFiles = "Disable",
                ignoredFiles = "Disable",
              },
              workspace = {
                maxPreload = 100,
                checkThirdParty = false,
              },
            },
          },
        },
      },
    },
  },
}

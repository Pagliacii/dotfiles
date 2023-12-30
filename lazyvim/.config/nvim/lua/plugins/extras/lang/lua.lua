local filetypes = { "lua" }
return {
  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "selene",
        -- "stylua",
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        require("null-ls").builtins.diagnostics.selene,
        -- require("null-ls").builtins.formatting.stylua,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ft = filetypes,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          filetypes = filetypes,
          root_dir = require("lspconfig.util").root_pattern("stylua.toml", "selene.toml"),
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
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                maxPreload = 16,
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
  },

  {
    "RRethy/nvim-treesitter-endwise",
    ft = filetypes,
  },
}

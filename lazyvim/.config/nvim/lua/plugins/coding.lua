return {
  {
    "hrsh7th/nvim-cmp",
    cond = false,
    ---@param opts cmp.ConfigSchema
    dependencies = {
      { "lukas-reineke/cmp-rg" },
      { "onsails/lspkind.nvim" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      table.insert(cmp.mapping.preset, {
        -- Accept multi-line completion
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Insert, select = false }),
      })
      opts.sources = cmp.config.sources({
        { name = "fittencode", group_index = 1 },
        { name = "nvim_lsp" },
        { name = "path" },
        {
          name = "rg",
          keyword_length = 3,
        },
        { name = "emoji" },
        { name = "neorg" },
        { name = "orgmode" },
      }, {
        { name = "buffer" },
      })
      opts.formatting = vim.tbl_extend("force", opts.formatting or {}, {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          show_labelDetails = true,
          symbol_map = {
            FittenCode = "",
            -- Codeium = "",
          },
        }),
      })

      -- From tjdevries/config.nvim
      -- : https://github.com/tjdevries/config.nvim/blob/784dc2623b66bfdda53b59de776e9c7d4a186d20/lua/custom/completion.lua#L38-L44
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })

      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })

      cmp.setup.filetype("DressingInput", {
        sources = cmp.config.sources({ { name = "omni" } }),
      })

      return opts
    end,
  },

  {
    "dnlhc/glance.nvim",
    config = true,
    cmd = { "Glance" },
    keys = {
      { "gpr", "<cmd>Glance references<cr>", desc = "Peek references", noremap = true },
      { "gpd", "<cmd>Glance definitions<cr>", desc = "Peek definitions", noremap = true },
      { "gpt", "<cmd>Glance type_definitions<cr>", desc = "Peek type definitions", noremap = true },
      { "gpi", "<cmd>Glance implementations<cr>", desc = "Peek implementations", noremap = true },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      if not opts.sources then
        opts.sources = {}
      end
      vim.list_extend(opts.sources, {
        null_ls.builtins.diagnostics.codespell.with({
          extra_args = { "-I", vim.fn.stdpath("config") .. "/spell/en.utf-8.add" },
        }),
        null_ls.builtins.completion.spell,
      })
    end,
  },

  {
    "stevearc/overseer.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      templates = { "builtin", "user" },
    },
  },

  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "gj",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
      {
        "gk",
        function()
          require("wtf").ai()
        end,
        desc = "Search diagnostic with AI",
      },
    },
  },

  {
    "trimclain/builder.nvim",
    cmd = "Build",
    keys = {
      {
        "<leader>cb",
        function()
          require("builder").build()
        end,
        desc = "Build",
      },
    },
    opts = {
      commands = {
        -- add your commands
        c = "clang % -o $basename.o && ./$basename.o",
        cpp = "clang++ % -o $basename.o && ./$basename.o",
        go = "go run %",
        markdown = "glow %",
        python = "python %",
        rust = "cargo run",
      },
    },
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      {
        "<leader>ty",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Yank history",
      },
    },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("refactoring").setup(opts)
      -- load refactoring Telescope extension
      if LazyVim.has("telescope.nvim") then
        require("telescope").load_extension("refactoring")
      end
    end,
    cmd = { "Refactor" },
    keys = {
      {
        "<leader>cRs",
        function()
          require("telescope").extensions.refactoring.refactors()
        end,
        mode = "v",
        desc = "Refactor",
      },
      {
        "<leader>cRi",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        "<leader>cRb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
      {
        "<leader>cRf",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        desc = "Extract Block To File",
      },
      {
        "<leader>cRP",
        function()
          require("refactoring").debug.printf({ below = true })
        end,
        desc = "Debug Print",
      },
      {
        "<leader>cRp",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        desc = "Debug Print Variable",
      },
      {
        "<leader>cRc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
      {
        "<leader>cRf",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "<leader>cRF",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        "<leader>cRx",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
      {
        "<leader>cRp",
        function()
          require("refactoring").debug.print_var()
        end,
        mode = "v",
        desc = "Debug Print Variable",
      },
    },
    opts = {
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
    },
  },

  {
    "chrisgrieser/nvim-puppeteer",
    lazy = false, -- plugin lazy-loads itself.
  },

  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
    keys = {
      { "<leader>ti", "<cmd>Telescope import<cr>", desc = "Import modules", noremap = true, silent = true },
    },
  },

  {
    "gregorias/coerce.nvim",
    tag = "v4.1.0",
    config = true,
    event = "BufReadPre",
  },

  {
    "LudoPinelli/comment-box.nvim",
    keys = {
      { "<leader>Cb", "<cmd>CBccbox<cr>", mode = { "n", "v" }, desc = "Box Title", noremap = true, silent = true },
      { "<leader>Ct", "<cmd>CBllline<cr>", mode = { "n", "v" }, desc = "Titled Line", noremap = true, silent = true },
      { "<leader>Cl", "<cmd>CBlline<cr>", mode = { "n", "v" }, desc = "Simple Line", noremap = true, silent = true },
      { "<leader>Cm", "<cmd>CBllbox14<cr>", mode = { "n", "v" }, desc = "Marked", noremap = true, silent = true },
      { "<leader>Cd", "<cmd>CBd<cr>", mode = { "n", "v" }, desc = "Remove a box", noremap = true, silent = true },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {
      highlight = {
        comments_only = false,
      },
    },
  },

  {
    "saghen/blink.cmp",
    version = not vim.g.lazyvim_blink_main and "*",
    build = vim.g.lazyvim_blink_main and "cargo build --release",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
      { "onsails/lspkind.nvim" },
    },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental signature help support
      -- signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = { "fittencode" },
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = {},
        providers = {
          fittencode = {
            name = "fittencode",
            module = "fittencode.sources.blink",
            async = true,
            score_offset = 0,
            kind = "FittenCode",
          },
        },
      },

      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- add ai_accept to <Tab> key
      if not opts.keymap["<Tab>"] then
        if opts.keymap.preset == "super-tab" then -- super-tab
          opts.keymap["<Tab>"] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
                return cmp.select_and_accept()
              end
            end,
            LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        else -- other presets
          opts.keymap["<Tab>"] = {
            LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        end
      end

      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require("blink.cmp").setup(opts)

      -- lspkind.lua
      local lspkind = require("lspkind")
      lspkind.init({
        symbol_map = {
          FittenCode = "",
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindFittenCode", { fg = "#6CC644" })
    end,
  },
}

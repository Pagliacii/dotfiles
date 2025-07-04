return {
  {
    "luozhiya/fittencode.nvim",
    enabled = false,
    event = "BufReadPost",
    cmd = "Fitten",
    opts = {
      completion_mode = "source", -- or "inline"
      source_completion = {
        enable = true,
        engine = "blink",
      },
      chat = {
        sidebar = {
          position = "right",
          width = 64,
        },
      },
      disable_specific_inline_completion = {
        -- Disable auto-completion for some specific file suffixes by entering them below
        -- For example, `suffixes = {'lua', 'cpp'}`
        -- it is an array of filetypes
        suffixes = { "TelescopePrompt" },
      },
      inline_completion = {
        -- Disable auto completion when pressing Backspace or Delete.
        ---@type boolean
        disable_completion_when_delete = true,
      },
      keymaps = {
        inline = {
          ["<TAB>"] = "accept_all_suggestions",
          ["<A-\\>"] = "triggering_completion",
        },
      },
    },
    keys = function(keys)
      local wk = require("which-key")
      local prefix = "<leader>af"
      wk.add({
        {
          mode = { "n", "v" },
          { prefix, group = "FittenCode", icon = { icon = "󰽽 ", color = "azure" } },
          {
            prefix .. "a",
            "<cmd>Fitten analyze_data<cr>",
            desc = "Analyze data",
            noremap = true,
            silent = true,
            icon = { icon = "󰟶 ", color = "red" },
          },
          {
            prefix .. "c",
            "<cmd>Fitten start_chat<cr>",
            desc = "Start a chat",
            noremap = true,
            silent = true,
            icon = { icon = "󱐏 ", color = "green" },
          },
          {
            prefix .. "d",
            "<cmd>Fitten document_code<cr>",
            desc = "Document code",
            noremap = true,
            silent = true,
            icon = { icon = "󰷈 ", color = "azure" },
          },
          {
            prefix .. "e",
            "<cmd>Fitten explain_code<cr>",
            desc = "Explain code",
            noremap = true,
            silent = true,
            icon = { icon = "󱍊 ", color = "yellow" },
          },
          {
            prefix .. "E",
            "<cmd>Fitten edit_code<cr>",
            desc = "Edit code",
            noremap = true,
            silent = true,
            icon = { icon = "󱓓 ", color = "orange" },
          },
          {
            prefix .. "f",
            "<cmd>Fitten find_bugs<cr>",
            desc = "Find bugs",
            noremap = true,
            silent = true,
            icon = { icon = "󰨮 ", color = "green" },
          },
          {
            prefix .. "g",
            function()
              local fitten = require("fittencode")
              local test_framework = vim.fn.input({
                prompt = "Enter test framework: ",
                default = "",
                cancelreturn = "",
              })
              local language = vim.fn.input({
                prompt = "Enter language: ",
                default = vim.bo.filetype,
                cancelreturn = vim.bo.filetype,
              })
              fitten.generate_unit_test({
                test_framework = test_framework,
                language = language,
              })
            end,
            desc = "Generate unit test",
            noremap = true,
            silent = true,
            icon = { icon = "󰇉 ", color = "red" },
          },
          {
            prefix .. "h",
            function()
              require("fittencode").has_suggestions()
            end,
            desc = "If suggestions are available",
            noremap = true,
            silent = true,
            icon = { icon = "󰍻 ", color = "blue" },
          },
          {
            prefix .. "i",
            "<cmd>Fitten implement_features<cr>",
            desc = "Implement features",
            noremap = true,
            silent = true,
            icon = { icon = "󱌢 ", color = "cyan" },
          },
          {
            prefix .. "I",
            "<cmd>Fitten identify_programming_language<cr>",
            desc = "Identify programming language",
            noremap = true,
            silent = true,
            icon = { icon = "󰈷 ", color = "purple" },
          },
          {
            prefix .. "l",
            function()
              require("fittencode").accept_line()
            end,
            desc = "Accept line",
            noremap = true,
            silent = true,
            icon = { icon = "󰄳 ", color = "green" },
          },
          {
            prefix .. "L",
            function()
              require("fittencode").revoke_line()
            end,
            desc = "Revoke line",
            noremap = true,
            silent = true,
            icon = { icon = "󰕍 ", color = "red" },
          },
          {
            prefix .. "o",
            "<cmd>Fitten optimize_code<cr>",
            desc = "Optimize code",
            noremap = true,
            silent = true,
            icon = { icon = "󱕍 ", color = "yellow" },
          },
          {
            prefix .. "r",
            "<cmd>Fitten refactor_code<cr>",
            desc = "Refactor code",
            noremap = true,
            silent = true,
            icon = { icon = " ", color = "blue" },
          },
          {
            prefix .. "S",
            function()
              local StatusCodes = {
                "DISABLED",
                "IDLE",
                "GENERATING",
                "ERROR",
                "NO_MORE_SUGGESTIONS",
                "SUGGESTIONS_READY",
              }
              vim.notify("Status: " .. StatusCodes[require("fittencode").get_current_status()])
            end,
            desc = "Get current status",
            noremap = true,
            silent = true,
            icon = { icon = "󱖫 ", color = "purple" },
          },
          {
            prefix .. "t",
            "<cmd>Fitten toggle_chat<cr>",
            desc = "Toggle chat",
            noremap = true,
            silent = true,
          },
          {
            prefix .. "T",
            "<cmd>Fitten translate_text<cr>",
            desc = "Translate text",
            noremap = true,
            silent = true,
            icon = { icon = "󰗊 ", color = "cyan" },
          },
          {
            prefix .. "w",
            function()
              require("fittencode").accept_word()
            end,
            desc = "Accept word",
            noremap = true,
            silent = true,
            icon = { icon = "󰄳 ", color = "green" },
          },
          {
            prefix .. "W",
            function()
              require("fittencode").revoke_word()
            end,
            desc = "Revoke word",
            noremap = true,
            silent = true,
            icon = { icon = "󰕍 ", color = "red" },
          },
          {
            prefix .. "1",
            "<cmd>Fitten translate_text_into_english<cr>",
            desc = "Translate text into English",
            noremap = true,
            silent = true,
            icon = { icon = "󰗊 ", color = "cyan" },
          },
          {
            prefix .. "2",
            "<cmd>Fitten translate_text_into_chinese<cr>",
            desc = "Translate text into Chinese",
            noremap = true,
            silent = true,
            icon = { icon = "󰗊 ", color = "cyan" },
          },
        },
      })
      return keys
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        opts = {
          show_model_choices = true,
        },
      },
      display = {
        inline = {
          layout = "vertical", -- vertical|horizontal|buffer
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          model = "claude-sonnet-4",
        },
        inline = {
          adapter = "copilot",
          model = "claude-sonnet-4",
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gR" },
              description = "Reject the suggested change",
            },
          },
        },
        cmd = {
          adapter = "copilot",
          model = "claude-sonnet-4",
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        vectorcode = {
          enabled = vim.fn.executable("vectorcode") == 1,
          ---@type VectorCode.CodeCompanion.extensionOpts
          opts = {
            tool_group = {
              -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
              enabled = true,
              -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
              -- if you use @vectorcode_vectorise, it'll be very handy to include
              -- `file_search` here.
              extras = {},
              collapse = false, -- whether the individual tools should be shown in the chat
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.ToolOpts
              ["*"] = {},
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = {},
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {},
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
                ---@type VectorCode.CodeCompanion.SummariseOpts
                summarise = {
                  ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]): boolean)|nil
                  enabled = true,
                  adapter = nil,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
  },

  {
    "Davidyz/VectorCode",
    version = "*",
    enabled = not jit.os:find("Windows"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
            "vectorcode",
          })
        end,
      },
    },
    cmd = "VectorCode",
  },
}

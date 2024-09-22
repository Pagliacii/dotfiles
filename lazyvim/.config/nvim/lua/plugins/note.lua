local function quicknote_cmd(name)
  return string.format("<cmd>lua require('quicknote').%s()<cr>", name)
end

local function toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<cr>", { noremap = true, silent = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<cr>", { noremap = true, silent = true })
    require("indent_blankline.commands").disable()
  else
    vim.cmd([[setlocal ve=]])
    vim.cmd([[mapclear <buffer>]])
    vim.b.venn_enabled = nil
    require("indent_blankline.commands").enable()
  end
end

local prefix = "<leader>n"
local neorg_prefix = "<leader>no"
local qn_prefix = "<leader>nq"
local zt_prefix = "<leader>nz"

return {
  {
    "RutaTang/quicknote.nvim",
    config = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { qn_prefix .. "lc", quicknote_cmd("NewNoteAtCurrentLine"), desc = "Create" },
      { qn_prefix .. "lo", quicknote_cmd("OpenNoteAtCurrentLine"), desc = "Open" },
      { qn_prefix .. "ld", quicknote_cmd("DeleteNoteAtCurrentLine"), desc = "Delete" },
      { qn_prefix .. "wc", quicknote_cmd("NewNoteAtCWD"), desc = "Create" },
      { qn_prefix .. "wo", quicknote_cmd("OpenNoteAtCWD"), desc = "Open" },
      { qn_prefix .. "wd", quicknote_cmd("DeleteNoteAtCWD"), desc = "Delete" },
      { qn_prefix .. "gc", quicknote_cmd("NewNoteAtGlobal"), desc = "Create" },
      { qn_prefix .. "go", quicknote_cmd("OpenNoteAtGlobal"), desc = "Open" },
      { qn_prefix .. "gd", quicknote_cmd("DeleteNoteAtGlobal"), desc = "Delete" },
      { qn_prefix .. "Lb", quicknote_cmd("ListNotesForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "Lc", quicknote_cmd("ListNotesForCWD"), desc = "CWD" },
      { qn_prefix .. "Lg", quicknote_cmd("ListNotesForGlobal"), desc = "Global" },
      { qn_prefix .. "Lf", quicknote_cmd("ListNotesForAFileOrWDInCWD"), desc = "File or dir" },
      { qn_prefix .. "jp", quicknote_cmd("JumpToPreviousNote"), desc = "Previous" },
      { qn_prefix .. "jn", quicknote_cmd("JumpToNextNote"), desc = "Next" },
      { qn_prefix .. "cb", quicknote_cmd("GetNotesCountForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "cc", quicknote_cmd("GetNotesCountForCWD"), desc = "CWD" },
      { qn_prefix .. "cg", quicknote_cmd("GetNotesCountForGlobal"), desc = "Global" },
      { qn_prefix .. "s", quicknote_cmd("ToggleNoteSigns"), desc = "Toggle signs" },
      { qn_prefix .. "eb", quicknote_cmd("ExportNotesForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "ec", quicknote_cmd("ExportNotesForCWD"), desc = "CWD" },
      { qn_prefix .. "eg", quicknote_cmd("ExportNotesForGlobal"), desc = "Global" },
      { qn_prefix .. "ib", quicknote_cmd("ImportNotesForCurrentBuffer"), desc = "Current buffer" },
      { qn_prefix .. "ic", quicknote_cmd("ImportNotesForCWD"), desc = "CWD" },
      { qn_prefix .. "ig", quicknote_cmd("ImportNotesForGlobal"), desc = "Global" },
    },
  },

  {
    "jbyuki/venn.nvim",
    cmd = { "VBox" },
    keys = {
      { prefix .. "v", toggle_venn, desc = "Venn", noremap = true },
    },
  },

  {
    "backdround/global-note.nvim",
    cmd = { "GlobalNote" },
    config = true,
    keys = {
      {
        prefix .. "g",
        function()
          require("global-note").toggle_note()
        end,
        desc = "Global Note",
        noremap = true,
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    ft = { "typ", "typst" },
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
    keys = {
      { prefix .. "tp", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst Preview", noremap = true },
      { prefix .. "tc", "<cmd>TypstPreviewSyncCursor<cr>", desc = "Sync Cursor", noremap = true },
      { prefix .. "ts", "<cmd>TypstPreview slide<cr>", desc = "Preview in slides", noremap = true },
    },
  },

  {
    "williamboman/mason.nvim",
    ft = { "typ", "typst" },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typstfmt",
        "typst-lsp",
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = { "typ", "typst" },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.typstfmt,
      })
    end,
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
      },
      { "bottd/neorg-worklog" },
      { "nvim-neorg/neorg-telescope" },
      { "juniorsundar/neorg-extras" },
    },
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.completion"] = {
            config = { engine = "nvim-cmp", name = "[Norg] " },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.concealer"] = { config = { icon_preset = "diamond" } },
          ["core.keybinds"] = {
            -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/module.lua
            config = {
              default_keybinds = true,
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = { config = { extensions = "all" } },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
          ["core.summary"] = {},
          ["core.ui.calendar"] = {},
          ["core.looking-glass"] = {},
          ["core.clipboard.code-blocks"] = {},
          ["core.esupports.hop"] = {},
          ["core.esupports.indent"] = {},
          ["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
          ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
          ["core.tangle"] = { config = { report_on_empty = false } },
          ["core.journal"] = { config = { strategy = "flat" } },
          ["core.integrations.telescope"] = {},
          ["core.pivot"] = {},
          ["core.promo"] = {},

          ["external.agenda"] = {},
          ["external.roam"] = {},
          ["external.worklog"] = {},
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
    keys = {
      { prefix .. "n", "<cmd>tabnew | Neorg index<cr>", desc = "Neorg Index" },
      { prefix .. "d", "<cmd>tabnew | Neorg journal today<cr>", desc = "Today Journal" },
      {
        prefix .. "k",
        function()
          local dirman = require("neorg").modules.get_module("core.dirman")
          dirman.create_file("tasks", "notes", {
            no_open = false, -- open file after creation?
            force = false, -- overwrite file if exists
            metadata = {}, -- key-value table for metadata fields
          })
        end,
        desc = "Neorg task",
      },
      { neorg_prefix .. "r", "<cmd>Neorg return<cr>", desc = "Return" },
      { neorg_prefix .. "a", "<cmd>Neorg agenda<cr>", desc = "Agenda" },
      { neorg_prefix .. "r", "<cmd>Neorg roam<cr>", desc = "Roam" },
      { neorg_prefix .. "t", "<cmd>Neorg cycle_task<cr>", desc = "Cycle task" },
    },
  },

  {
    "nvim-orgmode/orgmode",
    event = "BufRead",
    ft = { "org" },
    opts = {
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    },
  },

  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-telekasten/calendar-vim",
    },
    cmd = { "Telekasten" },
    opts = {
      home = vim.fn.expand("~/zettelkasten"),
    },
    keys = {
      { "<localleader>z", "<cmd>Telekasten panel<cr>", desc = "Panel", noremap = true },
      { zt_prefix .. "p", "<cmd>Telekasten panel<cr>", desc = "Panel", noremap = true },
      { zt_prefix .. "f", "<cmd>Telekasten find_notes<cr>", desc = "Find notes", noremap = true },
      { zt_prefix .. "F", "<cmd>Telekasten find_friends<cr>", desc = "Find friends", noremap = true },
      { zt_prefix .. "g", "<cmd>Telekasten search_notes<cr>", desc = "Search notes", noremap = true },
      { zt_prefix .. "d", "<cmd>Telekasten goto_today<cr>", desc = "Daily notes", noremap = true },
      { zt_prefix .. "D", "<cmd>Telekasten find_daily_notes<cr>", desc = "Find daily notes", noremap = true },
      { zt_prefix .. "w", "<cmd>Telekasten goto_thisweek<cr>", desc = "Weekly notes", noremap = true },
      { zt_prefix .. "W", "<cmd>Telekasten find_weekly_notes<cr>", desc = "Find weekly notes", noremap = true },
      { zt_prefix .. "z", "<cmd>Telekasten follow_link<cr>", desc = "Follow link", noremap = true },
      { zt_prefix .. "n", "<cmd>Telekasten new_note<cr>", desc = "New note", noremap = true },
      { zt_prefix .. "N", "<cmd>Telekasten new_templated_note<cr>", desc = "New note by template", noremap = true },
      { zt_prefix .. "c", "<cmd>Telekasten show_calendar<cr>", desc = "Calendar", noremap = true },
      { zt_prefix .. "b", "<cmd>Telekasten show_backlinks<cr>", desc = "Backlinks", noremap = true },
      { zt_prefix .. "t", "<cmd>Telekasten toggle_todo<cr>", desc = "Toggle todo", noremap = true },
      { zt_prefix .. "T", "<cmd>Telekasten show_tags<cr>", desc = "Tags", noremap = true },
      { zt_prefix .. "I", "<cmd>Telekasten insert_img_link<cr>", desc = "Insert image link", noremap = true },
      { "[[", "<cmd>Telekasten insert_link<cr>", mode = "i", desc = "Insert image link", noremap = true },
      { zt_prefix .. "p", "<cmd>Telekasten paste_img_and_link<cr>", desc = "Paste image and link", noremap = true },
      -- { zt_prefix .. "P", "<cmd>Telekasten preview_img<cr>", desc = "Preview image", noremap = true },
      { zt_prefix .. "y", "<cmd>Telekasten yank_notelink<cr>", desc = "Yank note link", noremap = true },
      -- { zt_prefix .. "B", "<cmd>Telekasten browse_media<cr>", desc = "Browse media files", noremap = true },
      { zt_prefix .. "r", "<cmd>Telekasten rename_note<cr>", desc = "Rename note", noremap = true },
      { zt_prefix .. "v", "<cmd>Telekasten switch_vault<cr>", desc = "Switch vault", noremap = true },
    },
  },

  {
    "JellyApple102/flote.nvim",
    config = true,
    cmd = "Flote",
    keys = {
      { prefix .. "f", "<cmd>Flote<cr>", desc = "Flote", noremap = true },
    },
  },
}

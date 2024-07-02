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

return {
  {
    "RutaTang/quicknote.nvim",
    config = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { prefix .. "lc", quicknote_cmd("NewNoteAtCurrentLine"), desc = "Create" },
      { prefix .. "lo", quicknote_cmd("OpenNoteAtCurrentLine"), desc = "Open" },
      { prefix .. "ld", quicknote_cmd("DeleteNoteAtCurrentLine"), desc = "Delete" },
      { prefix .. "cc", quicknote_cmd("NewNoteAtCWD"), desc = "Create" },
      { prefix .. "co", quicknote_cmd("OpenNoteAtCWD"), desc = "Open" },
      { prefix .. "cd", quicknote_cmd("DeleteNoteAtCWD"), desc = "Delete" },
      { prefix .. "Gc", quicknote_cmd("NewNoteAtGlobal"), desc = "Create" },
      { prefix .. "Go", quicknote_cmd("OpenNoteAtGlobal"), desc = "Open" },
      { prefix .. "Gd", quicknote_cmd("DeleteNoteAtGlobal"), desc = "Delete" },
      { prefix .. "Lb", quicknote_cmd("ListNotesForCurrentBuffer"), desc = "Current buffer" },
      { prefix .. "Lc", quicknote_cmd("ListNotesForCWD"), desc = "CWD" },
      { prefix .. "Lg", quicknote_cmd("ListNotesForGlobal"), desc = "Global" },
      { prefix .. "Lf", quicknote_cmd("ListNotesForAFileOrWDInCWD"), desc = "File or dir" },
      { prefix .. "jp", quicknote_cmd("JumpToPreviousNote"), desc = "Previous" },
      { prefix .. "jn", quicknote_cmd("JumpToNextNote"), desc = "Next" },
      { prefix .. "Cb", quicknote_cmd("GetNotesCountForCurrentBuffer"), desc = "Current buffer" },
      { prefix .. "Cc", quicknote_cmd("GetNotesCountForCWD"), desc = "CWD" },
      { prefix .. "Cg", quicknote_cmd("GetNotesCountForGlobal"), desc = "Global" },
      { prefix .. "s", quicknote_cmd("ToggleNoteSigns"), desc = "Toggle signs" },
      { prefix .. "Eb", quicknote_cmd("ExportNotesForCurrentBuffer"), desc = "Current buffer" },
      { prefix .. "Ec", quicknote_cmd("ExportNotesForCWD"), desc = "CWD" },
      { prefix .. "Eg", quicknote_cmd("ExportNotesForGlobal"), desc = "Global" },
      { prefix .. "Ib", quicknote_cmd("ImportNotesForCurrentBuffer"), desc = "Current buffer" },
      { prefix .. "Ic", quicknote_cmd("ImportNotesForCWD"), desc = "CWD" },
      { prefix .. "Ig", quicknote_cmd("ImportNotesForGlobal"), desc = "Global" },
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
}

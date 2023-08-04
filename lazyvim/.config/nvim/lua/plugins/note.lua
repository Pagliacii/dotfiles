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

return {
  {
    "RutaTang/quicknote.nvim",
    config = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>Nlc", quicknote_cmd("NewNoteAtCurrentLine"), desc = "Create" },
      { "<leader>Nlo", quicknote_cmd("OpenNoteAtCurrentLine"), desc = "Open" },
      { "<leader>Nld", quicknote_cmd("DeleteNoteAtCurrentLine"), desc = "Delete" },
      { "<leader>Ncc", quicknote_cmd("NewNoteAtCWD"), desc = "Create" },
      { "<leader>Nco", quicknote_cmd("OpenNoteAtCWD"), desc = "Open" },
      { "<leader>Ncd", quicknote_cmd("DeleteNoteAtCWD"), desc = "Delete" },
      { "<leader>Ngc", quicknote_cmd("NewNoteAtGlobal"), desc = "Create" },
      { "<leader>Ngo", quicknote_cmd("OpenNoteAtGlobal"), desc = "Open" },
      { "<leader>Ngd", quicknote_cmd("DeleteNoteAtGlobal"), desc = "Delete" },
      { "<leader>NLb", quicknote_cmd("ListNotesForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>NLc", quicknote_cmd("ListNotesForCWD"), desc = "CWD" },
      { "<leader>NLg", quicknote_cmd("ListNotesForGlobal"), desc = "Global" },
      { "<leader>NLf", quicknote_cmd("ListNotesForAFileOrWDInCWD"), desc = "File or dir" },
      { "<leader>Njp", quicknote_cmd("JumpToPreviousNote"), desc = "Previous" },
      { "<leader>Njn", quicknote_cmd("JumpToNextNote"), desc = "Next" },
      { "<leader>NCb", quicknote_cmd("GetNotesCountForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>NCc", quicknote_cmd("GetNotesCountForCWD"), desc = "CWD" },
      { "<leader>NCg", quicknote_cmd("GetNotesCountForGlobal"), desc = "Global" },
      { "<leader>Ns", quicknote_cmd("ToggleNoteSigns"), desc = "Toggle signs" },
      { "<leader>NEb", quicknote_cmd("ExportNotesForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>NEc", quicknote_cmd("ExportNotesForCWD"), desc = "CWD" },
      { "<leader>NEg", quicknote_cmd("ExportNotesForGlobal"), desc = "Global" },
      { "<leader>NIb", quicknote_cmd("ImportNotesForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>NIc", quicknote_cmd("ImportNotesForCWD"), desc = "CWD" },
      { "<leader>NIg", quicknote_cmd("ImportNotesForGlobal"), desc = "Global" },
    },
  },

  {
    "jbyuki/venn.nvim",
    cmd = { "VBox" },
    keys = {
      { "<leader>V", toggle_venn, desc = "Venn", noremap = true },
    },
  },
}

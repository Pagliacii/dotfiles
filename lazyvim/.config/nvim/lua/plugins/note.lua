local function quicknote_cmd(name)
  return string.format("<cmd>lua require('quicknote').%s()<cr>", name)
end

local function toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<cr>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<cr>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<cr>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<cr>", { noremap = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<cr>", { noremap = true })
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
      { "<leader>nlc", quicknote_cmd("NewNoteAtCurrentLine"), desc = "Create" },
      { "<leader>nlo", quicknote_cmd("OpenNoteAtCurrentLine"), desc = "Open" },
      { "<leader>nld", quicknote_cmd("DeleteNoteAtCurrentLine"), desc = "Delete" },
      { "<leader>ncc", quicknote_cmd("NewNoteAtCWD"), desc = "Create" },
      { "<leader>nco", quicknote_cmd("OpenNoteAtCWD"), desc = "Open" },
      { "<leader>ncd", quicknote_cmd("DeleteNoteAtCWD"), desc = "Delete" },
      { "<leader>ngc", quicknote_cmd("NewNoteAtGlobal"), desc = "Create" },
      { "<leader>ngo", quicknote_cmd("OpenNoteAtGlobal"), desc = "Open" },
      { "<leader>ngd", quicknote_cmd("DeleteNoteAtGlobal"), desc = "Delete" },
      { "<leader>nLb", quicknote_cmd("ListNotesForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>nLc", quicknote_cmd("ListNotesForCWD"), desc = "CWD" },
      { "<leader>nLg", quicknote_cmd("ListNotesForGlobal"), desc = "Global" },
      { "<leader>nLf", quicknote_cmd("ListNotesForAFileOrWDInCWD"), desc = "File or dir" },
      { "<leader>njp", quicknote_cmd("JumpToPreviousNote"), desc = "Previous" },
      { "<leader>njn", quicknote_cmd("JumpToNextNote"), desc = "Next" },
      { "<leader>nCb", quicknote_cmd("GetNotesCountForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>nCc", quicknote_cmd("GetNotesCountForCWD"), desc = "CWD" },
      { "<leader>nCg", quicknote_cmd("GetNotesCountForGlobal"), desc = "Global" },
      { "<leader>ns", quicknote_cmd("ToggleNoteSigns"), desc = "Toggle signs" },
      { "<leader>nEb", quicknote_cmd("ExportNotesForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>nEc", quicknote_cmd("ExportNotesForCWD"), desc = "CWD" },
      { "<leader>nEg", quicknote_cmd("ExportNotesForGlobal"), desc = "Global" },
      { "<leader>nIb", quicknote_cmd("ImportNotesForCurrentBuffer"), desc = "Current buffer" },
      { "<leader>nIc", quicknote_cmd("ImportNotesForCWD"), desc = "CWD" },
      { "<leader>nIg", quicknote_cmd("ImportNotesForGlobal"), desc = "Global" },
    },
  },

  {
    "nvim-neorg/neorg",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    },
    build = ":Neorg sync-parsers",
    config = function(_, opts)
      require("neorg").setup(opts)
      require("neorg.callbacks").on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = {
            { "<C-s>", "core.integrations.telescope.find_linkable" },
          },
          i = {
            { "<C-l>", "core.integrations.telescope.insert_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)
    end,
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
        ["core.integrations.telescope"] = {},
      },
    },
    ft = { "norg" },
  },

  {
    "jbyuki/venn.nvim",
    cmd = { "VBox" },
    keys = {
      { "<leader>V", toggle_venn, desc = "Toggle venn", noremap = true },
    },
  },
}

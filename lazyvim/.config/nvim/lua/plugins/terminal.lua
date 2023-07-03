local function init_or_toggle()
  vim.cmd([[ ToggleTermToggleAll ]])

  -- list current buffers
  local buffers = vim.api.nvim_list_bufs()

  -- check if toggleterm buffer exists. If not then create one by vim.cmd [[ exe 1 . "ToggleTerm" ]]
  local toggleterm_exists = false
  for _, buf in ipairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:find("toggleterm#") then
      toggleterm_exists = true
      break
    end
  end

  if not toggleterm_exists then
    vim.cmd([[ exe 1 . "ToggleTerm" ]])
  end
end

---@type { [integer]: { [string]: integer } }
local Terms = {}
---@type Terminal
local last_term

---Auto spawn a new terminal window
---@param dir string?
---@param direction string?
---@return string
local function new_terminal(dir, direction)
  if last_term then
    dir = dir or last_term.dir
    direction = direction or last_term.direction
  end
  dir = dir or "%"
  direction = direction or "horizontal"
  local cmd = string.format([[%dToggleTerm dir=%s direction=%s]], #Terms + 1, dir, direction)
  vim.cmd(cmd)
end

---Execute a command in terminal
local function exec_command()
  local cmd = vim.fn.input("Command: ")
  if #cmd > 0 then
    if not last_term then
      new_terminal()
    end
    require("toggleterm").exec(cmd, last_term.id, last_term.size, last_term.dir, last_term.direction)
  end
end

---Auto change last opened terminal direction or spawn a new one
---@param direction string
---@return function
local function toggle_terminal(direction)
  return function()
    if not last_term then
      new_terminal(nil, direction)
      return
    end

    local is_opened = last_term:is_open()
    if last_term.direction ~= direction then
      if is_opened then
        last_term:close()
      end
      last_term:toggle(nil, direction)
      last_term:set_mode(require("toggleterm.terminal").mode.INSERT)
      return
    end

    last_term:toggle(nil, direction)
    if last_term:is_open() then
      last_term:set_mode(require("toggleterm.terminal").mode.INSERT)
    end
  end
end

return {
  {
    "akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLine",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
    },
    opts = {
      ---@param t Terminal
      size = function(t)
        if t.direction == "vertical" then
          return vim.o.columns * 0.3
        elseif t.direction == "horizontal" then
          return 15
        end
      end,
      ---@param t Terminal
      on_create = function(t)
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
        Terms[t.id] = { name = t.name, previous = last_term }
        last_term = t

        -- keybindings
        local opts = { buffer = t.bufnr, silent = true }
        vim.keymap.set("n", "q", "<cmd>ToggleTerm<cr>", opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", function()
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-h>", true, true, true), "n")
        end, opts)
        vim.keymap.set("t", "<C-l>", function()
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-l>", true, true, true), "n")
        end, opts)
      end,
      ---@param t Terminal
      on_exit = function(t)
        last_term = Terms[t.id].previous
        Terms[t.id] = nil
      end,
      shading_factor = 2,
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
    keys = function(_, keys)
      vim.list_extend(keys, {
        { "<leader>Tt", init_or_toggle, desc = "Toggle or init" },
        { "<leader>Tn", new_terminal, desc = "New terminal" },
        { "<leader>Te", exec_command, desc = "Execute command" },
        { "<leader>Ts", "<cmd> TermSelect<cr>", desc = "Select" },
        { "<leader>Th", toggle_terminal("horizontal"), desc = "Toggle horizontal" },
        { "<leader>Tv", toggle_terminal("vertical"), desc = "Toggle vertical" },
        { "<leader>TT", toggle_terminal("tab"), desc = "Toggle tab" },
        { "<leader>Tf", toggle_terminal("float"), desc = "Toggle float" },
        { "<leader>TSc", "<cmd> ToggleTermSendCurrentLine<cr>", desc = "Line under cursor" },
        {
          "<leader>TSv",
          "<cmd> ToggleTermSendVisualLines<cr>",
          mode = "v",
          desc = "Lines in seletion",
        },
        {
          "<leader>TSs",
          "<cmd> ToggleTermSendVisualSelection<cr>",
          mode = "v",
          desc = "Text in selection",
        },
      })
      return keys
    end,
  },
}

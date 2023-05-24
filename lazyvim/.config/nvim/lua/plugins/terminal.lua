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
  vim.cmd(string.format('exe 1. "%dToggleTerm dir=%s direction=%s"', #Terms + 1, dir, direction))
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
    local is_opened = last_term and last_term:is_open()
    if not is_opened then
      new_terminal(nil, direction)
      return
    end

    if last_term.direction == direction then
      return
    end

    last_term:close()
    last_term:open(nil, direction)
    last_term:set_mode(require("toggleterm.terminal").mode.INSERT)
  end
end

return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
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
      local wk = require("which-key")
      wk.register({
        ["<leader>t"] = {
          name = "+terminal",
          mode = { "n", "v" },
          S = { name = "+send" },
        },
      })
      vim.list_extend(keys, {
        { "<leader>tt", init_or_toggle, desc = "Toggle or init" },
        { "<leader>tn", new_terminal, desc = "New terminal" },
        { "<leader>te", exec_command, desc = "New terminal" },
        { "<leader>ts", "<cmd> TermSelect<cr>", desc = "Select" },
        { "<leader>th", toggle_terminal("horizontal"), desc = "Toggle horizontal" },
        { "<leader>tv", toggle_terminal("vertical"), desc = "Toggle vertical" },
        { "<leader>tT", toggle_terminal("tab"), desc = "Toggle tab" },
        { "<leader>tf", toggle_terminal("float"), desc = "Toggle float" },
        { "<leader>tSc", "<cmd> ToggleTermSendCurrentLine<cr>", desc = "Line under cursor" },
        {
          "<leader>tSv",
          "<cmd> ToggleTermSendVisualLines<cr>",
          mode = "v",
          desc = "Lines in seletion",
        },
        {
          "<leader>tSs",
          "<cmd> ToggleTermSendVisualSelection<cr>",
          mode = "v",
          desc = "Text in selection",
        },
      })
      return keys
    end,
  },
}

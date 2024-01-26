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

local toggleterm = {
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
        desc = "Lines in selection",
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
}

local wezterm = {
  "willothy/wezterm.nvim",
  config = true,
  cmd = { "WeztermSpawn" },
  keys = {
    {
      "<leader>Wp",
      function()
        require("wezterm").switch_tab.relative(-1)
      end,
      desc = "Prev tab",
      silent = true,
      noremap = true,
    },
    {
      "<leader>Wn",
      function()
        require("wezterm").switch_tab.relative(1)
      end,
      desc = "Next tab",
      silent = true,
      noremap = true,
    },
    {
      "<leader>W-",
      function()
        require("wezterm").split_pane.vertical()
      end,
      desc = "Split pane below",
      silent = true,
      noremap = true,
    },
    {
      "<leader>W|",
      function()
        require("wezterm").split_pane.horizontal()
      end,
      desc = "Split pane right",
      silent = true,
      noremap = true,
    },
    {
      "<leader>Wj",
      function()
        require("wezterm").switch_pane.direction("Down")
      end,
      desc = "Switch to down pane",
      silent = true,
      noremap = true,
    },
    {
      "<leader>Wk",
      function()
        require("wezterm").switch_pane.direction("Up")
      end,
      desc = "Switch to up pane",
      silent = true,
      noremap = true,
    },
    {
      "<leader>Wh",
      function()
        require("wezterm").switch_pane.direction("Left")
      end,
      desc = "Switch to left pane",
      silent = true,
      noremap = true,
    },
    {
      "<leader>Wl",
      function()
        require("wezterm").switch_pane.direction("Right")
      end,
      desc = "Switch to right pane",
      silent = true,
      noremap = true,
    },
    {
      "<leader>WP",
      function()
        require("wezterm").switch_pane.direction("Prev")
      end,
      desc = "Switch to previous pane",
      silent = true,
      noremap = true,
    },
    {
      "<leader>WN",
      function()
        require("wezterm").switch_pane.direction("Next")
      end,
      desc = "Switch to next pane",
      silent = true,
      noremap = true,
    },
  },
}

local flatten = {
  "willothy/flatten.nvim",
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = 1001,
  opts = function()
    ---@type Terminal?
    local saved_terminal

    return {
      window = {
        open = "alternate",
      },
      callbacks = {
        should_block = function(argv)
          -- Note that argv contains all the parts of the CLI command, including
          -- Neovim's path, commands, options and files.
          -- See: :help v:argv

          -- In this case, we would block if we find the `-b` flag
          -- This allows you to use `nvim -b file1` instead of
          -- `nvim --cmd 'let g:flatten_wait=1' file1`
          return vim.tbl_contains(argv, "-b")

          -- Alternatively, we can block if we find the diff-mode option
          -- return vim.tbl_contains(argv, "-d")
        end,
        pre_open = function()
          local term = require("toggleterm.terminal")
          local termid = term.get_focused_id()
          saved_terminal = term.get(termid)
        end,
        post_open = function(bufnr, winnr, ft, is_blocking)
          if is_blocking and saved_terminal then
            -- Hide the terminal while it's blocking
            saved_terminal:close()
          else
            -- If it's a normal file, just switch to its window
            vim.api.nvim_set_current_win(winnr)

            -- If we're in a different wezterm pane/tab, switch to the current one
            -- Requires willothy/wezterm.nvim
            require("wezterm").switch_pane.id(tonumber(os.getenv("WEZTERM_PANE")))
          end

          -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
          -- If you just want the toggleable terminal integration, ignore this bit
          if ft == "gitcommit" or ft == "gitrebase" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              buffer = bufnr,
              once = true,
              callback = vim.schedule_wrap(function()
                vim.api.nvim_buf_delete(bufnr, {})
              end),
            })
          end
        end,
        block_end = function()
          -- After blocking ends (for a git commit, etc), reopen the terminal
          vim.schedule(function()
            if saved_terminal then
              saved_terminal:open()
              saved_terminal = nil
            end
          end)
        end,
      },
    }
  end,
}

return {
  toggleterm,
  flatten,
  wezterm,
}

local filetypes = { "markdown" }
local leader_key = "<leader>m"

local function get_file_path()
  local file_path = vim.fn.expand("%:p")
  if file_path ~= "" then
    return file_path
  end

  -- Get the content of the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(lines, "\n")

  -- Create a temporary file to store the content
  local tmp_file = os.tmpname()
  local file = io.open(tmp_file, "w")
  file:write(content)
  file:close()
  return tmp_file
end

vim.keymap.set("n", leader_key .. "m", function()
  if vim.fn.executable("markmap") ~= 1 then
    vim.notify("Markmap not found", vim.log.levels.ERROR)
  end

  local cmd = vim.fn.exepath("markmap")
  local file_path = get_file_path()
  -- Create a temporary file to store the HTML content
  local tmp_file = vim.fn.tempname() .. ".html"
  vim.system({ cmd, "--offline", "--output", tmp_file, file_path }, { text = true })
end, { desc = "Markmap", silent = true, noremap = true })

vim.keymap.set("n", leader_key .. "s", function()
  if vim.fn.executable("slides") ~= 1 then
    vim.notify("Slides not found", vim.log.levels.ERROR)
  end

  local cmd = vim.fn.exepath("slides")
  local file_path = get_file_path()
  -- Run the command
  LazyVim.terminal.open({ cmd, file_path }, {
    esc_esc = false,
    ctrl_hjkl = false,
    ft = "slides",
    size = {
      width = vim.api.nvim_get_option("columns"),
      height = vim.api.nvim_get_option("lines"),
    },
  })
end, { desc = "Slides", silent = true, noremap = true })

vim.keymap.set("n", leader_key .. "l", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Find the start of the word
  local start = col + 1
  while start > 0 and line:sub(start, start):match("[^%s]") do
    start = start - 1
  end
  start = start + 1

  -- Find the end of the word
  local finish = col + 1
  while finish <= #line and line:sub(finish, finish):match("[^%s]") do
    finish = finish + 1
  end
  finish = finish - 1

  -- Extract the word
  local word = line:sub(start, finish)

  -- Replace the word with the link format
  local new_text = "[" .. word .. "]()"
  local new_line = line:sub(1, start - 1) .. new_text .. line:sub(finish + 1)

  -- Update the line
  vim.api.nvim_set_current_line(new_line)

  -- Move the cursor inside the parentheses
  vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), start + #word + 2 })

  -- Change to insert mode
  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Linkify" })

vim.keymap.set("v", leader_key .. "l", function()
  local util = require("obsidian.util")
  local viz = util.get_visual_selection()
  local line = viz.lines[1]
  -- Replace the word with the link format
  local new_text = "[" .. viz.selection .. "]()"
  local new_line = line:sub(1, viz.cscol - 1) .. new_text .. line:sub(viz.cecol + 1)

  -- Update the line
  vim.api.nvim_set_current_line(new_line)

  -- Move the cursor inside the parentheses
  vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), viz.cscol + #viz.selection + 2 })

  -- Change to insert mode
  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Linkify" })

vim.keymap.set("n", leader_key .. "c", "i```\n```<Esc>kA", { noremap = true, silent = true, desc = "Code block" })

vim.keymap.set("n", leader_key .. "k", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Find the start of the word
  local start = col + 1
  while start > 0 and line:sub(start, start):match("[^%s]") do
    start = start - 1
  end
  start = start + 1

  -- Find the end of the word
  local finish = col + 1
  while finish <= #line and line:sub(finish, finish):match("[^%s]") do
    finish = finish + 1
  end
  finish = finish - 1

  -- Extract the word
  local word = line:sub(start, finish)

  -- Replace the word with the link format
  local new_text = "<kbd>" .. word .. "</kbd>"
  local new_line = line:sub(1, start - 1) .. new_text .. line:sub(finish + 1)

  -- Update the line
  vim.api.nvim_set_current_line(new_line)

  -- Move the cursor inside the parentheses
  vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), start + #word + 5 })
end, { noremap = true, silent = true, desc = "Insert kbd tag" })

vim.keymap.set("v", leader_key .. "k", function()
  local util = require("obsidian.util")
  local viz = util.get_visual_selection()
  local line = viz.lines[1]
  local col = viz.cscol
  local text = line:sub(col, col)
  local new_text = "<kbd>" .. text .. "</kbd>"
  local new_line = line:sub(1, col - 1) .. new_text .. line:sub(col + 1)

  -- Update the line
  vim.api.nvim_set_current_line(new_line)

  -- Move the cursor inside the parentheses
  vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), col + #new_text - 1 })
end, { noremap = true, silent = true, desc = "Insert kbd tag" })

return {
  {
    "ellisonleao/glow.nvim",
    enabled = vim.fn.executable("glow") == 1,
    config = true,
    cmd = { "Glow" },
    keys = {
      { leader_key .. "g", "<cmd>Glow<cr>", desc = "Preview in glow", silent = true },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_theme = "light"
    end,
    keys = function()
      return {
        {
          leader_key .. "b",
          ft = "markdown",
          "<cmd>MarkdownPreviewToggle<cr>",
          desc = "Preview in browser",
          silent = true,
        },
      }
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = filetypes,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      vim.list_extend(opts.sources or {}, {
        null_ls.builtins.diagnostics.write_good,
        null_ls.builtins.hover.dictionary,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    ft = filetypes,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "glow",
        "markdown-toc",
        "markmap-cli",
        "prettierd",
        "write-good",
      })
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    ft = filetypes,
    event = "BufReadPre",
    opts = {},
    keys = {
      { leader_key .. "p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image", noremap = true },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = true,
        -- icons = { "◉ ", "○ ", "◆ ", "◇ ", "★ ", "✸ " },
      },
      code = {
        sign = true,
        left_pad = 2,
        right_pad = 2,
        width = "block",
      },
    },
    checkbox = {
      custom = {
        doing = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownWarn" },
      },
    },
  },
}

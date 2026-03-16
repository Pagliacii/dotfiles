return {
  name = "poetry run",
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "poetry" },
      args = { "run", "python", file },
      components = {
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}

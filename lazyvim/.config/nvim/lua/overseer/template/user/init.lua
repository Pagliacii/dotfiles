local M = {
  "py_run",
  "poetry_run",
}

function M:attach_prefix()
  local t = {}
  for index, value in ipairs(self) do
    t[index] = "user." .. value
  end
  return t
end

return M:attach_prefix()

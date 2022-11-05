local M = {}

local home = os.getenv("HOME")

function M.home_path(path)
  return home .. "/" .. path
end

return M

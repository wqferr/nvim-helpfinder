local M = {}

function M.search(term)
    local search_cmd = ([[lhelpgrep \*.*\c\V%s\v.*\*]]):format(term)
    vim.cmd(search_cmd)

    vim.cmd [[lopen | helpc]]
end

return M

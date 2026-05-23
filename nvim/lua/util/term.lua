local M = {}

local term_buf = nil
local term_win = nil

function M.toggle()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, false)
    term_win = nil
    return
  end

  vim.cmd("rightbelow " .. math.floor(vim.o.lines * 0.3) .. "split")
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.api.nvim_set_current_buf(term_buf)
  else
    vim.cmd("terminal")
    term_buf = vim.api.nvim_get_current_buf()
    vim.bo[term_buf].buflisted = false
  end
  term_win = vim.api.nvim_get_current_win()
  vim.cmd("startinsert")
end

return M

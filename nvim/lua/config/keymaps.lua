-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Editor-scoped bottom terminal: opens below the current window only
-- (scoped to the editor column, so neo-tree stays full-height).
local term_buf = nil
local term_win = nil

local function toggle_editor_term()
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

vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_editor_term, { desc = "Toggle editor terminal" })
vim.keymap.set("n", "<leader>tt", toggle_editor_term, { desc = "Toggle editor terminal" })
vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

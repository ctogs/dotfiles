-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Editor-scoped bottom terminal: opens below the current window only
-- (scoped to the editor column, so neo-tree stays full-height).
local term = require("util.term")

vim.keymap.set({ "n", "t" }, "<C-\\>", term.toggle, { desc = "Toggle editor terminal" })
vim.keymap.set("n", "<leader>tt", term.toggle, { desc = "Toggle editor terminal" })
vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

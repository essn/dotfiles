-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map jk to ESC in insert mode
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
-- Map jk to ESC in insert mode
vim.keymap.set("v", "jk", "<Esc>", { noremap = true, silent = true })

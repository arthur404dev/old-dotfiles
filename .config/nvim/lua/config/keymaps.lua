-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- vim.keymap.del("n", "<leader>w|")
vim.keymap.set("n", "<leader>w\\", "<C-W>v", { desc = "Split window right", remap = true })
-- vim.keymap.del("n", "<leader>|")
vim.keymap.set("n", "<leader>\\", "<C-W>v", { desc = "Split window right", remap = true })

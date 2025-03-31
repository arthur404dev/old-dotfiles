local keymap = vim.keymap
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Remaps
keymap.set("n", "gh", "K", { desc = "Show Hover", remap = true })
-- User Scripts
keymap.set("n", "<leader>za", "G$vgg0", { desc = "Select all", remap = true })
keymap.set("n", "<leader>zx", "<cmd> source %<CR>", { desc = "Source Current", remap = true })
keymap.set("n", "<leader>z<space>", "<cmd> source ~/.config/nvim/init.lua<CR>", { desc = "Source Config", remap = true })
keymap.set("n", "<leader>zz", ":.lua<CR>", { desc = "Run Lua Line", remap = true })
keymap.set("v", "<leader>zz", ":lua<CR>", { desc = "Run Lua Block", remap = true })


-- Deletes
keymap.del("n", "<leader>K")
keymap.del("n", "<leader>-")
keymap.del("n", "<leader>|")
keymap.del("n", "<leader>`")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- Unmap LazyVim defaults we want to override
pcall(del, "n", "<leader>f ")
pcall(del, "n", "<leader>ff")
pcall(del, "n", "<leader>fg")
pcall(del, "n", "<leader>fb")
pcall(del, "n", "<leader>fr")

-- Telescope keymaps
map("n", "<leader>f ", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Telescope)" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Telescope)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep (Telescope)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers (Telescope)" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files (Telescope)" })

map("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

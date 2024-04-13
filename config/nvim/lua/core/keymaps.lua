vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit" })
keymap.set("n", "<leader>cs", ":nohl<CR>", { desc = "Clear search highlights" })

-- Lazy
keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

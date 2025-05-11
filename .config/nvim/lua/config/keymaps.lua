vim.g.mapleader = " "
local keymap = vim.keymap.set
keymap("n", "<leader>o", "<cmd>Neotree float toggle<CR>", { desc = "Toggle floating neotree" })


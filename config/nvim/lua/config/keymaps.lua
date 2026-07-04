vim.keymap.set("i", "<C-s>", "<Esc>", { noremap = true })
vim.keymap.set('i', '<Space>', '<Space><C-g>u')
vim.keymap.set('i', '<CR>', '<CR><C-g>u')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })


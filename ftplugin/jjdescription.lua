vim.keymap.set({ 'n', 'i' }, '<C-c><C-c>', '<cmd>write | bdelete<CR>', { desc = 'Confirm', silent = true, buffer = true })
vim.keymap.set({ 'n', 'i' }, '<C-c><C-k>', '<cmd>bdelete!<CR>', { desc = 'Cancel', silent = true, buffer = true })

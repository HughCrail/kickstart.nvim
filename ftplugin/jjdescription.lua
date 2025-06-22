vim.keymap.set({ 'n', 'i' }, '<C-c><C-c>', ':write | bdelete<CR>', { desc = 'Confirm' })
vim.keymap.set({ 'n', 'i' }, '<C-c><C-k>', ':bdelete!<CR>', { desc = 'cancel' })

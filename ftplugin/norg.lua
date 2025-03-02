vim.keymap.set('n', '<leader>mc', '`<cmd>Neorg toc<CR>`', { buffer = true, desc = 'Table of contents' })
vim.keymap.set('n', '<leader>mC', '<cmd>Neorg toggle-concealer<CR>', { buffer = true, desc = 'Toggle concealer' })

local overwrittenKeymaps = {
  -- Mark the task under the cursor as "undone"
  -- ^mark Task as Undone
  {
    '<leader>mtu',
    '<Plug>(neorg.qol.todo-items.todo.task-undone)',
    opts = { desc = '[neorg] Mark as Undone' },
  },

  -- Mark the task under the cursor as "pending"
  -- ^mark Task as Pending
  {
    '<leader>mtp',
    '<Plug>(neorg.qol.todo-items.todo.task-pending)',
    opts = { desc = '[neorg] Mark as Pending' },
  },

  -- Mark the task under the cursor as "done"
  -- ^mark Task as Done
  {
    '<leader>mtd',
    '<Plug>(neorg.qol.todo-items.todo.task-done)',
    opts = { desc = '[neorg] Mark as Done' },
  },

  -- Mark the task under the cursor as "on-hold"
  -- ^mark Task as on Hold
  {
    '<leader>mth',
    '<Plug>(neorg.qol.todo-items.todo.task-on-hold)',
    opts = { desc = '[neorg] Mark as On Hold' },
  },

  -- Mark the task under the cursor as "cancelled"
  -- ^mark Task as Cancelled
  {
    '<leader>mtc',
    '<Plug>(neorg.qol.todo-items.todo.task-cancelled)',
    opts = { desc = '[neorg] Mark as Cancelled' },
  },

  -- Mark the task under the cursor as "recurring"
  -- ^mark Task as Recurring
  {
    '<leader>mtr',
    '<Plug>(neorg.qol.todo-items.todo.task-recurring)',
    opts = { desc = '[neorg] Mark as Recurring' },
  },

  -- Mark the task under the cursor as "important"
  -- ^mark Task as Important
  {
    '<leader>mti',
    '<Plug>(neorg.qol.todo-items.todo.task-important)',
    opts = { desc = '[neorg] Mark as Important' },
  },

  -- Mark the task under the cursor as "ambiguous"
  -- ^mark Task as Ambiguous
  {
    '<leader>mta',
    '<Plug>(neorg.qol.todo-items.todo.task-ambiguous)',
    opts = { desc = '[neorg] Mark as Ambigous' },
  },

  -- Switch the task under the cursor between a select few states
  {
    '<C-t>',
    '<Plug>(neorg.qol.todo-items.todo.task-cycle)',
    opts = { desc = '[neorg] Cycle Task' },
  },

  -- Toggle a list from ordered <-> unordered
  -- ^List Toggle
  {
    '<leader>mlt',
    '<Plug>(neorg.pivot.list.toggle)',
    opts = { desc = '[neorg] Toggle (Un)ordered List' },
  },

  -- Invert all items in a list
  -- Unlike `<leader>mlt`, inverting a list will respect mixed list
  -- items, instead of snapping all list types to a single one.
  -- ^List Invert
  {
    '<leader>mli',
    '<Plug>(neorg.pivot.list.invert)',
    opts = { desc = '[neorg] Invert (Un)ordered List' },
  },

  -- Insert a link to a date at the given position
  -- ^Insert Date
  { '<leader>mid', '<Plug>(neorg.tempus.insert-date)', opts = { desc = '[neorg] Insert Date' } },

  -- Magnifies a code block to a separate buffer.
  -- ^Code Magnify
  {
    '<leader>mm',
    '<Plug>(neorg.looking-glass.magnify-code-block)',
    opts = { desc = '[neorg] Magnify Code Block' },
  },
}

for _, keymap in ipairs(overwrittenKeymaps) do
  keymap.opts.buffer = true
  vim.keymap.set('n', keymap[1], keymap[2], keymap.opts)
end

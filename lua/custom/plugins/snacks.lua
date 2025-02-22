return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type Snacks.Config
  opts = {
    bigfile = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
  },
  keys = {
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<leader>vp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search plugin specs',
    },
    {
      '<leader>ii',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Insert Icons',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Search buffer lines',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undotree',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
  },
}

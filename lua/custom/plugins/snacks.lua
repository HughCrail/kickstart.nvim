return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type Snacks.Config
  opts = {
    terminal = { enabled = true },
  },
  keys = {
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
  },
}

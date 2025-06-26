return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.misc').setup()
    require('mini.operators').setup {
      replace = {
        prefix = 'go',
      },
      exchange = {
        prefix = 'gX',
      },
    }
    require('mini.move').setup()
    -- vim.keymap.set('n', '<leader>ww', MiniMisc.zoom, { desc = 'Zoom Window' }) BUG: This is broken
  end,
}

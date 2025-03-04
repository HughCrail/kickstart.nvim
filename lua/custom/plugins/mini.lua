return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.misc').setup()
    vim.keymap.set('n', '<leader>ww', MiniMisc.zoom, { desc = 'Zoom Window' })
  end,
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    options = {
      disabled_filetypes = {
        statusline = { 'snacks_dashboard' },
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics', 'overseer' },
      lualine_c = {
        {
          'filetype',
          icon_only = true,
          separator = '',
          padding = { left = 1, right = 0 },
        },
        {
          'filename',
          padding = { left = 0, right = 0 },
        },
      },
      lualine_x = {
        {
          require('noice').api.status.mode.get,
          cond = require('noice').api.status.mode.has,
          color = { fg = '#ff9e64' },
        },
        {
          require('noice').api.status.search.get,
          cond = require('noice').api.status.search.has,
          color = { fg = '#ff9e64' },
        },
      },
      lualine_y = { 'location' },
      lualine_z = { "os.date(' %R')" },
    },
    extensions = { 'oil', 'lazy', 'mason', 'overseer', 'quickfix' },
  },
}

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
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'overseer', { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } } },
      lualine_y = { 'progress', 'searchcount', 'selectioncount', 'location' },
      lualine_z = { "os.date(' %R')" },
    },
    extensions = { 'oil', 'lazy', 'mason', 'overseer', 'quickfix' },
  },
}

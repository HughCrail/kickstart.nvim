return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  opts = {
    load = {
      ['core.keybinds'] = {
        config = {
          default_keybinds = false,
        },
      },
      ['core.defaults'] = {},
      ['core.concealer'] = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/notes',
          },
          default_workspace = 'notes',
        },
      },
      ['core.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
    },
  },
}

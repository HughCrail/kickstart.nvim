return {
  'nvim-neorg/neorg',
  enabled = false,
  lazy = false,
  version = '*',
  opts = {
    load = {
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

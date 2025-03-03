local plugin_specs = {
  'tpope/vim-sleuth',
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    },
  },

  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'carbonfox'
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    enabled = false,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
    },
  },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
      'folke/snacks.nvim',
    },
    opts = {
      disable_hint = true,
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
    keys = {
      {
        '<leader>gg',
        function()
          local git = require 'snacks.git'
          require('neogit').open { cwd = git.get_root(), kind = 'replace' }
        end,
        desc = 'Open Neogit',
      },
    },
  },
  {
    'ton/vim-bufsurf',
    init = function()
      vim.keymap.set('n', '<leader>bn', '<Plug>(buf-surf-forward)', { desc = 'Next Buffer' })
      vim.keymap.set('n', '<leader>bp', '<Plug>(buf-surf-back)', { desc = 'Prev Buffer' })
    end,
  },
}
if vim.env.NVIM_JOB_PLUGIN then
  table.insert(plugin_specs, {
    {
      dir = vim.env.NVIM_JOB_PLUGIN,
      opts = {},
    },
  })
end
return plugin_specs

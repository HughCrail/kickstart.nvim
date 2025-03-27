local plugin_specs = {
  'tpope/vim-sleuth',
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'carbonfox'
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
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'sindrets/diffview.nvim',
        opts = {
          view = {
            merge_tool = {
              layout = 'diff3_mixed',
            },
          },
        },
      },
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

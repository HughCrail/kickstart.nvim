return {
  'tpope/vim-sleuth',
  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_enabled = true
      -- if windows then set copilot_workspace_folders to repo dir
      if vim.fn.has 'win32' then
        vim.g.copilot_workspace_folders = { 'C:/dev/repos' }
      end
    end,
    config = function()
      vim.keymap.set('i', '<m-l>', 'copilot#AcceptWord("")', {
        expr = true,
        desc = 'Accept Copilot Word',
        silent = true,
      })
      vim.keymap.set('i', '<m-j>', 'copilot#AcceptLine("")', {
        expr = true,
        desc = 'Accept Copilot Line',
        silent = true,
      })
      -- Toggle Copilot
      vim.keymap.set('n', '<leader>tc', function()
        if vim.g.copilot_enabled then
          vim.cmd 'Copilot disable'
          vim.g.copilot_enabled = false
          vim.notify 'Copilot disabled'
        else
          vim.cmd 'Copilot enable'
          vim.g.copilot_enabled = true
          vim.notify 'Copilot enabled'
        end
      end, {
        desc = 'Toggle Copilot',
      })
    end,
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
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
    opts = { signs = false },
  },

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
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
    keys = {
      {
        '<leader>gg',
        function()
          local git = require 'snacks.git'
          require('neogit').open { cwd = git.get_root() }
        end,
        desc = 'Open Neogit',
      },
    },
  },
}

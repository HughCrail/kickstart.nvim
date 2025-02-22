return { -- Fuzzy Finder (files, lsp, etc)
  'vim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'ahmedkhalf/project.nvim',
      opts = {
        detection_methods = { 'lsp', 'pattern' },
        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { '.git' },

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},
      },
      event = 'VeryLazy',
      config = function(_, opts)
        require('project_nvim').setup(opts)
      end,
    },
    'nvim-telescope/telescope-file-browser.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<c-enter>'] = 'to_fuzzy_refine',
            ['<c-j>'] = 'move_selection_next',
            ['<c-k>'] = 'move_selection_previous',
          },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'projects')

    vim.keymap.set('n', '<leader>o-', function()
      -- Open the file browser in the directory of the current file
      require('telescope').extensions.file_browser.file_browser {
        cwd = vim.fn.expand '%:p:h',
      }
    end, { desc = 'Open file browser' })

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>pp', function()
      require('telescope').extensions.projects.projects()
    end, { desc = 'Find recent projects' })
    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}

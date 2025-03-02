return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mrcjkb/rustaceanvim',
      'folke/snacks.nvim',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'rustaceanvim.neotest',
        },
        consumers = {
          overseer = require 'neotest.consumers.overseer',
        },
      }
    end,
    keys = {
      {
        '<leader>pt',
        function()
          require('neotest').run.run(require('snacks.git').get_root())
        end,
        desc = 'Run test in project',
      },
      {
        '<leader>th',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run test file',
      },
      {

        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop test',
      },
      {
        '<leader>tw',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = 'Toggle Watch (Neotest)',
      },
      {
        '<leader>tos',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Summary (Neotest)',
      },
      {
        '<leader>too',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'Show Output (Neotest)',
      },
      {
        '<leader>top',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'Toggle Output Panel (Neotest)',
      },
    },
  },
}

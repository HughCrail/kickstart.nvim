return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
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
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        map('n', '<leader>gbb', gitsigns.blame, { desc = 'git blame buffer' })
        map('n', '<leader>gbl', gitsigns.blame_line, { desc = 'git blame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git diff against last commit' })

        map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
        map('n', '<leader>ghh', gitsigns.preview_hunk_inline, { desc = 'Preview Hunk' })

        require('snacks').toggle
          .new({
            name = 'Current Line Blame',
            get = function()
              return require('gitsigns.config').config.current_line_blame
            end,
            set = function(state)
              require('gitsigns.config').config.current_line_blame = state
              gitsigns.refresh()
            end,
          })
          :map('<leader>ub', { buffer = bufnr })
      end,
    },
  },
}

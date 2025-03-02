---@module "snacks"

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
    },
    bigfile = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
    picker = {
      frecency = true,
    },
    gitbrowse = {
      config = function(opts, _)
        for _, v in ipairs(vim.g.additional_gitbrowse_remote_patterns or {}) do
          table.insert(opts.remote_patterns, v)
        end
        for k, v in pairs(vim.g.additional_gitbrowse_url_patterns or {}) do
          opts.url_patterns[k] = v
        end
      end,
    },
  },
  keys = {
    {
      '<leader>gll',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>glf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>d',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Search Diagnostics In Buffer',
    },
    {
      '<leader>D',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Search Diagnostics',
    },
    {
      '<leader>vf',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Search Neovim files',
    },
    {
      '<leader>vpc',
      function()
        Snacks.picker.grep { dirs = { vim.fn.stdpath 'data' .. '/lazy' } }
      end,
      desc = 'Search Lazy Plugins',
    },
    {
      '<leader>pp',
      function()
        Snacks.picker.projects {
          dev = vim.g.repo_dir,
          win = {
            input = {
              keys = {
                ['<c-g>'] = {
                  'open_neogit',
                  mode = { 'n', 'i' },
                },
              },
            },
          },
          actions = {
            open_neogit = function(p, item)
              if item then
                require('neogit').open { cwd = Snacks.picker.util.dir(item) }
              end
            end,
          },
        }
      end,
      desc = 'Search Projects',
    },
    {
      '<leader>glL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>go',
      function()
        Snacks.gitbrowse()
      end,
      mode = { 'n', 'v' },
      desc = 'Git Browse',
    },
    {
      '<leader>st',
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.todo_comments()
      end,
      desc = 'Search TODOs',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.pickers()
      end,
      desc = 'Search Picker Sources',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Search Recent Files',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      "<leader>'",
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>hk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>hs',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep {
          dirs = { require('snacks.git').get_root() },
        }
      end,
      desc = 'Grep (Root Dir)',
    },
    {
      '<leader>*',
      function()
        Snacks.picker.grep {
          dirs = { require('snacks.git').get_root() },
          search = require('snacks.picker.core.picker'):word(),
        }
      end,
      mode = { 'n', 'v' },
      desc = 'Grep (Root Dir)',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.grep {
          dirs = { vim.fn.expand '%:p:h' },
        }
      end,
      desc = 'Search Directory',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.grep {
          dirs = { vim.fn.expand '%:p:h' },
          search = require('snacks.picker.core.picker'):word(),
        }
      end,
      desc = 'Search Directory',
    },
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<c-/>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<leader>vps',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search plugin specs',
    },
    {
      '<leader>ii',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Insert Icons',
    },
    {
      '<leader>ss',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Search buffer lines',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undotree',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>bb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>bB',
      function()
        Snacks.picker.buffers { hidden = true, nofile = true }
      end,
      desc = 'Buffers (all)',
    },
    {
      '<leader>pf',
      function()
        Snacks.picker.git_files {
          cwd = require('snacks.git').get_root(),
          untracked = true,
          submodules = true,
        }
      end,
      desc = 'Find Files (git-files)',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
}

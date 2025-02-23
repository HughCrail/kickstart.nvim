---@module "snacks"

local picker = require 'snacks.picker'
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
    picker = {
      frecency = true,
    },
  },
  keys = {
    {
      '<leader>pp',
      function()
        picker.projects()
      end,
      desc = 'Search Projects',
    },
    {
      '<leader>o-',
      function()
        picker.explorer()
      end,
      desc = 'Open file browser',
    },
    {
      '<leader>gB',
      function()
        picker.git_log_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>go',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
    },
    {
      '<leader>st',
      function()
        ---@diagnostic disable-next-line: undefined-field
        picker.todo_comments()
      end,
      desc = 'Search TODOs',
    },
    {
      '<leader>sp',
      function()
        picker.pickers()
      end,
      desc = 'Search Picker Sources',
    },
    {
      '<leader>fr',
      function()
        picker.recent()
      end,
      desc = 'Search Recent Files',
    },
    {
      '<leader>sq',
      function()
        picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sd',
      function()
        picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      "<leader>'",
      function()
        picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>hk',
      function()
        picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sM',
      function()
        picker.man()
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sm',
      function()
        picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>hs',
      function()
        picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>/',
      function()
        picker.git_grep {
          untracked = true,
          submodules = true,
        }
      end,
      desc = 'Grep (Root Dir)',
    },
    {
      '<leader><space>',
      function()
        picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<c-/>',
      function()
        require 'snacks.terminal'()
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<leader>vp',
      function()
        picker.lazy()
      end,
      desc = 'Search plugin specs',
    },
    {
      '<leader>ii',
      function()
        picker.icons()
      end,
      desc = 'Insert Icons',
    },
    {
      '<leader>ss',
      function()
        picker.lines()
      end,
      desc = 'Search buffer lines',
    },
    {
      '<leader>su',
      function()
        picker.undo()
      end,
      desc = 'Undotree',
    },
    {
      '<leader>s/',
      function()
        picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>:',
      function()
        picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>bb',
      function()
        picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>bB',
      function()
        picker.buffers { hidden = true, nofile = true }
      end,
      desc = 'Buffers (all)',
    },
    {
      '<leader>pf',
      function()
        picker.git_files()
      end,
      desc = 'Find Files (git-files)',
    },
  },
}

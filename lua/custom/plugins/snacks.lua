---@module "snacks"

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
    -- Find files in config
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
        Snacks.picker.projects()
      end,
      desc = 'Search Projects',
    },
    {
      '<leader>o-',
      function()
        Snacks.picker.explorer()
      end,
      desc = 'Open file browser',
    },
    {
      '<leader>gB',
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
      '<leader>sd',
      function()
        Snacks.picker.files()
      end,
      desc = 'Search Directory',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.files()
      end,
      desc = 'Search Directory',
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
        Snacks.picker.git_grep {
          untracked = true,
          submodules = true,
        }
      end,
      desc = 'Grep (Root Dir)',
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
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
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
        Snacks.picker.git_files()
      end,
      desc = 'Find Files (git-files)',
    },
  },
}

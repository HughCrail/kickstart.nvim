-- with lazy.nvim
return {
  'LintaoAmons/bookmarks.nvim',
  -- pin the plugin at specific version for stability
  -- backup your bookmark sqlite db when there are breaking changes
  tag = '3.1.0',
  dependencies = {
    { 'kkharji/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' }, -- currently has only telescopes supported, but PRs for other pickers are welcome
    { 'stevearc/dressing.nvim' }, -- optional: better UI
  },
  config = function()
    local opts = {
      treeview = {
        window_split_dimension = 60,
      },
    } -- check the "./lua/bookmarks/default-config.lua" file for all the options
    require('bookmarks').setup(opts) -- you must call setup to init sqlite db
  end,
  keys = {
    {
      '<leader>;;',
      function()
        require('bookmarks').toggle_treeview()
      end,
      desc = 'Toggle Bookmarks Treeview',
    },
    {
      '<leader>;l',
      function()
        require('bookmarks').bookmark_lists()
      end,
      desc = 'Find Bookmarks List',
    },
    {
      '<leader>;a',
      function()
        require('bookmarks').toggle_mark()
      end,
      desc = 'Toggle Bookmark at Cursor',
    },
    {
      '<leader>;d',
      function()
        require('bookmarks').attach_desc()
      end,
      desc = 'Toggle Bookmark at Cursor W/ Description',
    },
    {
      '<leader>;f',
      function()
        require('bookmarks').goto_bookmark()
      end,
      desc = 'Find Bookmarks',
    },
    {
      '<leader>;I',
      function()
        require('bookmarks').info()
      end,
      desc = 'Bookmark Info',
    },
    {
      '];',
      function()
        require('bookmarks').goto_next_list_bookmark()
      end,
      desc = 'Find Bookmarks',
    },
    {
      '[;',
      function()
        require('bookmarks').goto_prev_list_bookmark()
      end,
      desc = 'Find Bookmarks',
    },
    {
      ';L',
      function()
        require('bookmarks').link_bookmark()
      end,
      desc = 'Find Bookmarks',
    },
  },
}

-- run :BookmarksInfo to see the running status of the plugin

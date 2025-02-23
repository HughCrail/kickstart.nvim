return {
  'lalitmee/browse.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = {
    bookmarks = {
      ['github'] = {
        ['name'] = 'Github',
        ['code_search'] = 'https://github.com/search?q=%s&type=code',
        ['repo_search'] = 'https://github.com/search?q=%s&type=repositories',
        ['issues_search'] = 'https://github.com/search?q=%s&type=issues',
        ['pulls_search'] = 'https://github.com/search?q=%s&type=pullrequests',
      },
    },
  },
  keys = {
    {
      '<leader>soa',
      function()
        require('browse').browse()
      end,
      mode = { 'n', 'v' },
      desc = 'Search Online',
    },
    {
      '<leader>sod',
      function()
        require('browse.devdocs').search_with_filetype(require('browse.utils').get_visual_text())
      end,
      mode = { 'n', 'v' },
      desc = 'Search Docs Online',
    },
    {
      '<leader>som',
      function()
        require('browse.mdn').search(require('browse.utils').get_visual_text())
      end,
      mode = { 'n', 'v' },
      desc = 'Search MDN Online',
    },
    {
      '<leader>sob',
      function()
        require('browse').open_bookmarks()
      end,
      mode = { 'n', 'v' },
      desc = 'Search Bookmarks Online',
    },
    {
      '<leader>soo',
      function()
        require('browse').input_search()
      end,
      mode = { 'n', 'v' },
      desc = 'Search Google Online',
    },
    -- like above but use the word under the cursor
    {
      '<leader>sOB',
      function()
        require('browse').open_bookmarks {
          visual_text = vim.fn.expand '<cword>',
        }
      end,
      desc = 'Search Bookmarks Online',
    },
    {
      '<leader>sOD',
      function()
        require('browse.devdocs').search_with_filetype(vim.fn.expand '<cword>')
      end,
      desc = 'Search Docs Online',
    },
    {
      '<leader>sOM',
      function()
        require('browse.mdn').search(vim.fn.expand '<cword>')
      end,
      desc = 'Search MDN Online',
    },
    {

      '<leader>sOO',
      function()
        require('browse.input').search_input(vim.fn.expand '<cword>')
      end,
      desc = 'Search Google Online',
    },
  },
}

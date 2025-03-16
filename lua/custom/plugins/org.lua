return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  dependencies = {
    'nvim-orgmode/org-bullets.nvim',
    'danilshvalov/org-modern.nvim',
  },
  ft = { 'org' },
  config = function()
    local Menu = require 'org-modern.menu'
    require('orgmode').setup {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
      ui = {
        input = {
          use_vim_ui = true,
        },
        menu = {
          handler = function(data)
            Menu:new({
              window = {
                margin = { 1, 0, 1, 0 },
                padding = { 0, 1, 0, 1 },
                title_pos = 'center',
                border = 'single',
                zindex = 1000,
              },
              icons = {
                separator = '➜',
              },
            }):open(data)
          end,
        },
      },
    }
    require('org-bullets').setup()
  end,
}

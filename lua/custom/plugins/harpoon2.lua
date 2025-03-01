return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    {
      '<leader>H',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon File',
    },
    {
      '<leader>sh',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon Quick Menu',
    },
    {
      '<leader>!',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(1)
      end,
      desc = 'Go To Harpoon 1',
    },
    {
      '<leader>"',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(2)
      end,
      desc = 'Go To Harpoon 2',
    },
    {
      '<leader>£',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():select(3)
      end,
      desc = 'Go To Harpoon 3',
    },
    {
      ']h',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():next()
      end,
      desc = 'Go To Previous Harpoon',
    },
    {
      '[h',
      function()
        local harpoon = require 'harpoon'
        harpoon:list():prev()
      end,
      desc = 'Go To Next Harpoon',
    },
  },
}

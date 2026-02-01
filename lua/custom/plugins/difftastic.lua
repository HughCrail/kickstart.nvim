return {
  'clabby/difftastic.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  config = function()
    require('difftastic-nvim').setup()
  end,
  keys = {
    {
      '<leader>jd',
      function()
        require('difftastic-nvim').open '@'
      end,
      desc = 'Open diff of current jj revision',
    },
  },
}

local plugin_specs = {
  'tpope/vim-sleuth',
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'carbonfox'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
    },
  },

  -- require 'kickstart.plugins.debug',
  {
    'ton/vim-bufsurf',
    init = function()
      vim.keymap.set('n', '<leader>bn', '<Plug>(buf-surf-forward)', { desc = 'Next Buffer' })
      vim.keymap.set('n', '<leader>bp', '<Plug>(buf-surf-back)', { desc = 'Prev Buffer' })
    end,
  },
}
if vim.env.NVIM_JOB_PLUGIN then
  table.insert(plugin_specs, {
    {
      dir = vim.env.NVIM_JOB_PLUGIN,
      opts = {},
    },
  })
end
return plugin_specs

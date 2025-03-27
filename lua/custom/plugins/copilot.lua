return {
  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_workspace_folders = { vim.g.repo_dir }
    end,
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      vim.keymap.set('i', '<m-l>', 'copilot#AcceptWord("")', {
        expr = true,
        desc = 'Accept Copilot Word',
        silent = true,
      })
      vim.keymap.set('i', '<m-j>', 'copilot#AcceptLine("")', {
        expr = true,
        desc = 'Accept Copilot Line',
        silent = true,
      })

      -- Toggle Copilot

      require('snacks').toggle
        .new({
          name = 'Copilot',
          get = function()
            return vim.g.copilot_enabled
          end,
          set = function(state)
            if state then
              vim.cmd 'Copilot enable'
              vim.g.copilot_enabled = true
            else
              vim.cmd 'Copilot disable'
              vim.g.copilot_enabled = false
            end
          end,
        })
        :map '<leader>uc'
    end,
  },
}

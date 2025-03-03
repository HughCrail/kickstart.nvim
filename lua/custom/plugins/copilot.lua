return {
  {
    'github/copilot.vim',
    init = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_maps = true
      vim.g.copilot_workspace_folders = { vim.g.repo_dir }
    end,
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
      vim.keymap.set('n', '<leader>Tc', function()
        if vim.g.copilot_enabled then
          vim.cmd 'Copilot disable'
          vim.g.copilot_enabled = false
          vim.notify 'Copilot disabled'
        else
          vim.cmd 'Copilot enable'
          vim.g.copilot_enabled = true
          vim.notify 'Copilot enabled'
        end
      end, {
        desc = 'Toggle Copilot',
      })
      -- Block the normal Copilot suggestions
      vim.api.nvim_create_augroup('github_copilot', { clear = true })
      vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload', 'BufEnter' }, {
        group = 'github_copilot',
        callback = function(args)
          vim.fn['copilot#On' .. args.event]()
        end,
      })
    end,
  },
  -- TODO: Toggle?
  {
    'saghen/blink.cmp',
    dependencies = { 'fang2hou/blink-copilot' },
    opts = {
      sources = {
        default = { 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 0,
            async = true,
          },
        },
      },
    },
  },
}

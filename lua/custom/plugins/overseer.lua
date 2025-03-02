local doActionOnLastTask = function(action)
  local overseer = require 'overseer'
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    vim.notify('No tasks found', vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], action)
  end
end
return {
  'stevearc/overseer.nvim',
  opts = {},
  keys = {
    {
      '<leader>tt',
      function()
        doActionOnLastTask 'restart'
      end,
      desc = 'Restart most recent test/task',
    },
    {
      '<leader>ts',
      function()
        doActionOnLastTask 'open'
      end,
      desc = 'Show last task',
    },
    {
      '<leader>tr',
      ':OverseerRun<cr>',
      desc = 'Run task',
    },
    {
      '<leader>tor',
      ':OverseerToggle<cr>',
      desc = 'Show task run panel',
    },
  },
}

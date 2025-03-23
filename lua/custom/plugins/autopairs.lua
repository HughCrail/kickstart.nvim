return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require 'nvim-autopairs'
      npairs.setup {}
      local Rule = require 'nvim-autopairs.rule'
      local cond = require 'nvim-autopairs.conds'
      npairs.add_rules { Rule('|', '|', { 'rust', 'go', 'lua' }):with_move(cond.after_regex '|') }
    end,
  },
}

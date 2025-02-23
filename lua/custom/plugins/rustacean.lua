---@module 'rustaceanvim'
return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    enabled = false,
    lazy = false, -- This plugin is already lazy
    init = function()
      ---@type rustaceanvim.Opts
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>me', function()
              vim.cmd.RustLsp 'explainError'
            end, { silent = true, buffer = bufnr })
          end,
        },
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    opts = {
      adapters = {
        ['rustaceanvim.neotest'] = {},
      },
    },
  },
}

---@module 'rustaceanvim'
return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
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
        default_settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = true,
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
            files = {
              excludeDirs = {
                '.direnv',
                '.git',
                '.github',
                '.gitlab',
                'bin',
                'node_modules',
                'target',
                'venv',
                '.venv',
              },
            },
          },
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

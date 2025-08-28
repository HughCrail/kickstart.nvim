local function has_prettier_config_impl(ctx)
  vim.system { 'npx', '--no', 'prettier', '--find-config-path', ctx.filename }
  return vim.v.shell_error == 0
end

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'never' }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    format_after_save = {
      timeout_ms = 500,
      lsp_format = 'never',
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      markdown = { 'prettier' },
      rust = { 'rustfmt' },
      go = { 'gofmt' },
    },
  },
}

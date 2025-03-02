local ftCond = function(ft)
  return function()
    -- filtype is norg
    return vim.bo.filetype == ft
  end
end

return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'helix',
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Code' },
      { '<leader>cw', group = 'Workspace' },
      { '<leader>f', group = 'File' },
      { '<leader>g', group = 'Git' },
      { '<leader>gb', group = 'Blame' },
      { '<leader>h', group = 'Help' },
      { '<leader>i', group = 'Insert' },
      { '<leader>m', group = 'Mode' },
      { '<leader>mi', group = 'Insert', cond = ftCond 'norg' },
      { '<leader>ml', group = 'List', cond = ftCond 'norg' },
      { '<leader>mt', group = 'Task', cond = ftCond 'norg' },
      { '<leader>n', group = 'Note' },
      { '<leader>o', group = 'Open' },
      { '<leader>p', group = 'Project' },
      { '<leader>q', group = 'Quit' },
      { '<leader>s', group = 'Search' },
      { '<leader>sO', group = 'Search Online For Thing At Point' },
      { '<leader>so', group = 'Search Online' },
      { '<leader>t', group = 'Task/Test' },
      { '<leader>T', group = 'Toggle' },
      { '<leader>v', group = 'Vim' },
      { '<leader>vp', group = 'Vim Plugins' },
      { '<leader>w', group = 'Window' },
    },
  },
}

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
--
-- Make line numbers default
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--  Use <leader>w+<hjkl> to switch between windows
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Move to window below' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move to window on the left' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Move to window on the right' })

local todo = function()
  vim.cmd 'echo "unimplemented"'
end
-- Doom compatible keybinds
vim.keymap.set('n', '<leader>fs', '<cmd>w<cr><esc>', { desc = 'Save the current buffer' })
vim.keymap.set('n', '<leader>bn', vim.cmd.bn, { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bp', vim.cmd.bp, { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>qq', vim.cmd.qa, { desc = 'Quit ' })
vim.keymap.set('n', '<leader>wv', vim.cmd.vsp, { desc = 'Veritcal Split ' })
vim.keymap.set('n', '<leader>ws', vim.cmd.sp, { desc = 'Horizontal Split ' })
vim.keymap.set('n', '<leader>wd', vim.cmd.clo, { desc = 'Close Window ' })
vim.keymap.set('n', '<leader>ff', '<cmd>e %:p:h<tab>', { desc = 'Find File' })
vim.keymap.set('n', '<leader>wm', vim.cmd.only, { desc = 'Close all other windows' })
vim.keymap.set('n', '<leader>wu', todo, { desc = 'Undo Window ' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0.1
  vim.keymap.set('n', '<leader>tf', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = 'Toggle Fullscreen' })
end

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

require 'config.lazy'

-- vim: ts=2 sts=2 sw=2 et

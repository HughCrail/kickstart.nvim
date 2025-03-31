-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.repo_dir = (vim.env.REPO_DIR or '~/repos'):gsub('\\', '/')

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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

-- Set spell check to US English
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

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
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set the width for which gq will wrap to
vim.opt.textwidth = 80

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set({ 'n' }, '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n' }, '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n' }, '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n' }, '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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
vim.keymap.set('n', '<leader>qq', vim.cmd.qa, { desc = 'Quit ' })
vim.keymap.set('n', '<leader>wv', vim.cmd.vsp, { desc = 'Veritcal Split ' })
vim.keymap.set('n', '<leader>ws', vim.cmd.sp, { desc = 'Horizontal Split ' })
vim.keymap.set('n', '<leader>wd', vim.cmd.clo, { desc = 'Close Window ' })
vim.keymap.set('n', '<leader>ff', function()
  local p = vim.fn.expand '%:h:p'
  vim.fn.feedkeys(':e ' .. p .. '/', 'n')
end, { desc = 'Find File' })
vim.keymap.set('n', '<leader>wM', vim.cmd.only, { desc = 'Close all other windows' })
vim.keymap.set('n', '<leader>wu', todo, { desc = 'Undo Window ' })
vim.keymap.set('n', '<leader>qt', vim.cmd.tabclose, { desc = 'Close Tab' })
vim.keymap.set('n', '<leader>fn', ':enew | startinsert<cr>', { desc = 'New File' })
vim.keymap.set('n', '<leader>br', ':e %<cr>', { desc = 'Refresh buffer', silent = true })

vim.keymap.set('n', '<m-q>', 'gwip', { desc = 'Reflow paragraph' })
vim.keymap.set('n', '<leader>bl', '<c-6>', { desc = 'Toggle last buffer' })

vim.keymap.set('n', '<leader>fo', require('custom.utils').gotoNextOtherFile, { desc = 'Find Other File' })

vim.keymap.set('t', '<C-S-v>', '<C-\\><C-N>"+pA', { desc = 'Paste from clipboard' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local projectBindings = {
  ['aoc-2023'] = function()
    vim.keymap.set('n', '<leader>ar', function()
      local fname = vim.api.nvim_buf_get_name(0)
      local bname = vim.fs.basename(fname)
      if not bname then
        return
      end
      local day = string.match(bname, '^(%d+).rs$')
      if day then
        local overseer = require 'overseer'
        local task = overseer.new_task {
          cmd = 'cargo',
          args = { 'read', day },
          cwd = require('snacks.git').get_root(fname),
        }
        task:start()
        overseer.run_action(task, 'open')
      end
    end, { buffer = true, desc = 'Read this days puzzle description' })
  end,
}

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set up project specific keybinds',
  callback = function()
    local path = vim.fn.expand '<afile>'
    -- return if path starts with a protocol like diffview://
    if path:match 'NeogitStatus' or path == '' or path:match '://' then
      return
    end

    local root = require('snacks.git').get_root(path)
    if root then
      pcall(function()
        local absPath = vim.fs.normalize(vim.fs.abspath(root))
        local repoName = vim.fs.basename(absPath)
        local projBindings = projectBindings[repoName]
        if projBindings then
          projBindings()
        end
      end)
    end
  end,
})

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

if vim.fn.has 'win32' == 1 then
  vim.opt.shell = 'cmd.exe'
end

if vim.g.neovide or vim.g.nvy or vim.g.goneovim then
  vim.fn.chdir(vim.g.repo_dir)
end

local font = 'FiraCode Nerd Font'
local defaut_size = 15
vim.o.guifont = font .. ':h' .. defaut_size

if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_position_animation_length = 0
  vim.keymap.set('n', '<leader>uf', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = 'Toggle Fullscreen' })
  vim.keymap.set('n', '<f11>', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = 'Toggle Fullscreen' })

  vim.keymap.set({ 'n', 'v' }, '<C-+>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end, { desc = 'Increase Font Size' })
  vim.keymap.set({ 'n', 'v' }, '<C-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
  end, { desc = 'Decrease Font Size' })
  vim.keymap.set({ 'n', 'v' }, '<C-=>', function()
    vim.g.neovide_scale_factor = 1
  end, { desc = 'Reset Font Size' })
end

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

require 'config.lazy'

-- vim: ts=2 sts=2 sw=2 et

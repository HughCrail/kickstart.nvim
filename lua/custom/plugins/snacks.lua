---@module "snacks"

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
    picker = {
      frecency = true,
    },
  },
  keys = function()
    local keymappings = {
      {
        '<leader>vf',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Search Neovim files',
      },
      {
        '<leader>vpc',
        function()
          Snacks.picker.grep { dirs = { vim.fn.stdpath 'data' .. '/lazy' } }
        end,
        desc = 'Search Lazy Plugins',
      },
      {
        '<leader>pp',
        function()
          Snacks.picker.projects {}
        end,
        desc = 'Search Projects',
      },
      {
        '<leader>o-',
        function()
          Snacks.picker.explorer()
        end,
        desc = 'Open file browser',
      },
      {
        '<leader>gB',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>go',
        function()
          Snacks.gitbrowse()
        end,
        mode = { 'n', 'v' },
        desc = 'Git Browse',
      },
      {
        '<leader>st',
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.todo_comments()
        end,
        desc = 'Search TODOs',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.pickers()
        end,
        desc = 'Search Picker Sources',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Search Recent Files',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.files {
            cwd = vim.fn.expand '%:p:h',
          }
        end,
        desc = 'Search Directory',
      },
      {
        "<leader>'",
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>hk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sM',
        function()
          Snacks.picker.man()
        end,
        desc = 'Man Pages',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>hs',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.grep {
            dirs = { require('snacks.git').get_root() },
          }
        end,
        desc = 'Grep (Root Dir)',
      },
      {
        '<leader>*',
        function()
          Snacks.picker.grep {
            dirs = { require('snacks.git').get_root() },
            search = require('snacks.picker.core.picker'):word(),
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Grep (Root Dir)',
      },
      {
        '<leader><space>',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<leader>vps',
        function()
          Snacks.picker.lazy()
        end,
        desc = 'Search plugin specs',
      },
      {
        '<leader>ii',
        function()
          Snacks.picker.icons()
        end,
        desc = 'Insert Icons',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Search buffer lines',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undotree',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>n',
        function()
          Snacks.picker.notifications()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>bb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>bB',
        function()
          Snacks.picker.buffers { hidden = true, nofile = true }
        end,
        desc = 'Buffers (all)',
      },
      {
        '<leader>pf',
        function()
          Snacks.picker.git_files {
            cwd = require('snacks.git').get_root(),
            untracked = true,
            submodules = true,
          }
        end,
        desc = 'Find Files (git-files)',
      },
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
    }

    if vim.fn.has 'win32' then
      -- TODO: Add picker for searching in R+ bundles in repos - identified by the presence of a bundle.json file
      table.insert(keymappings, {
        '<leader>su',
        function()
          Snacks.picker.grep {
            dirs = { 'C:/dev/repos/uiinf-sotr' },
            title = 'uiinf-sotr',
          }
        end,
        desc = 'Search uiinf-sotr',
      })
      table.insert(keymappings, {
        '<leader>sU',
        function()
          Snacks.picker.grep {
            dirs = { 'C:/dev/repos/uiinf-sotr' },
            search = require('snacks.picker.core.picker'):word(),
            title = 'uiinf-sotr',
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Search uiinf-sotr for thing at point',
      })
      table.insert(keymappings, {
        '<leader>pr',
        function()
          require('custom.utils').get_rplus_dirs(function(dirs)
            local items = {}
            for _, path in ipairs(dirs) do
              table.insert(items, {
                text = vim.fs.basename(path),
                file = path,
              })
            end
            Snacks.picker.pick {
              format = 'file',
              title = 'R+ Bundles',
              items = items,
              confirm = 'load_session',
              win = {
                preview = { minimal = true },
                input = {
                  keys = {
                    -- every action will always first change the cwd of the current tabpage to the project
                    ['<c-e>'] = { { 'tcd', 'picker_explorer' }, mode = { 'n', 'i' } },
                    ['<c-f>'] = { { 'tcd', 'picker_files' }, mode = { 'n', 'i' } },
                    ['<c-g>'] = { { 'tcd', 'picker_grep' }, mode = { 'n', 'i' } },
                    ['<c-r>'] = { { 'tcd', 'picker_recent' }, mode = { 'n', 'i' } },
                    ['<c-w>'] = { { 'tcd' }, mode = { 'n', 'i' } },
                    ['<c-t>'] = {
                      function(picker)
                        vim.cmd 'tabnew'
                        Snacks.notify 'New tab opened'
                        picker:close()
                        Snacks.picker.projects()
                      end,
                      mode = { 'n', 'i' },
                    },
                  },
                },
              },
            }
          end)
        end,
        desc = 'Find R+ Bundles',
      })
      table.insert(keymappings, {
        '<leader>sb',
        function()
          require('custom.utils').get_rplus_dirs(function(dirs)
            Snacks.picker.grep { dirs = dirs, title = 'R+ Bundles' }
          end)
        end,
        desc = 'Search in R+ Bundles',
      })
    end

    return keymappings
  end,
}

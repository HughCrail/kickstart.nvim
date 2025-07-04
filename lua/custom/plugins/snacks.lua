---@module "snacks"

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
    },
    bigfile = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
    picker = {
      frecency = true,
    },
    gitbrowse = {
      config = function(opts, _)
        for _, v in ipairs(vim.g.additional_gitbrowse_remote_patterns or {}) do
          table.insert(opts.remote_patterns, v)
        end
        for k, v in pairs(vim.g.additional_gitbrowse_url_patterns or {}) do
          opts.url_patterns[k] = v
        end
      end,
    },
    toggle = {
      notify = false,
    },
    words = {
      enabled = true,
    },
    zen = {
      toggles = {
        dim = false,
      },
    },
  },
  init = function()
    local Snacks = require 'snacks'
    Snacks.toggle.line_number():map '<leader>ul'
    Snacks.toggle.zoom():map('<leader>wm'):map '<leader>uZ'
    Snacks.toggle.zen():map '<leader>z'
    Snacks.toggle.inlay_hints():map '<leader>uh'
    Snacks.toggle.diagnostics():map '<leader>ud'
    Snacks.toggle.words():map '<leader>uw'
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>gll',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>glf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>d',
      function()
        Snacks.picker.diagnostics_buffer {
          layout = {
            preset = 'vertical',
            layout = {
              width = 0,
            },
          },
        }
      end,
      desc = 'Search Diagnostics In Buffer',
    },
    {
      '<leader>D',
      function()
        Snacks.picker.diagnostics {
          layout = {
            preset = 'vertical',
            layout = {
              width = 0,
            },
          },
        }
      end,
      desc = 'Search Diagnostics',
    },
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
      '<leader>pP',
      function()
        Snacks.picker.projects {
          dev = vim.g.repo_dir,
          win = {
            input = {
              keys = {
                ['<c-g>'] = {
                  'open_neogit',
                  mode = { 'n', 'i' },
                },
                ['<c-l>'] = {
                  'open_jjui',
                  mode = { 'n', 'i' },
                },
              },
            },
          },
          actions = {
            open_neogit = function(_, item)
              if item then
                local dir = Snacks.picker.util.dir(item)
                vim.api.nvim_set_current_dir(dir)
                require('neogit').open { cwd = dir, kind = 'replace' }
              end
            end,
            open_jjui = require('custom.utils').openJJFromPicker,
          },
        }
      end,
      desc = 'Search Projects',
    },
    {
      '<leader>glL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git Blame Line',
    },
    {
      '<leader>go',
      function()
        Snacks.gitbrowse {
          what = 'permalink',
          open = function(url)
            vim.fn.setreg('*', url)
            vim.fn.setreg('0', url)
            vim.ui.open(url)
          end,
        }
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
      '<leader>sd',
      function()
        Snacks.picker.grep {
          dirs = { vim.fn.expand '%:p:h' },
        }
      end,
      desc = 'Search Directory',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.grep {
          dirs = { vim.fn.expand '%:p:h' },
          search = require('snacks.picker.core.picker'):word(),
        }
      end,
      desc = 'Search Directory',
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
        local bufFileDir = vim.fn.expand '%:p:h'
        if vim.bo.filetype == 'oil' then
          bufFileDir = require('oil').get_current_dir() or bufFileDir
        end
        Snacks.terminal(nil, {
          cwd = require('snacks.git').get_root(bufFileDir) or bufFileDir,
        })
      end,
      desc = 'Toggle Terminal',
    },
    {
      '<leader>ot',
      function()
        Snacks.terminal(nil, { cwd = vim.fn.expand '%:p:h' })
      end,
      desc = 'Open Terminal For Current File Dir',
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
    {
      '<leader>fS',
      function()
        local specialFiles = {}
        -- Add vim.g.special_work_files to specialFiles
        for _, v in ipairs(vim.g.special_work_files or {}) do
          table.insert(specialFiles, {
            text = v,
            file = v,
          })
        end

        Snacks.picker.pick {
          format = 'file',
          title = 'Special Files',
          items = specialFiles,
          win = {
            preview = { minimal = true },
          },
        }
      end,
      desc = 'Find Special File',
    },
    {
      ']r',
      function()
        Snacks.words.jump(vim.v.count1, true)
      end,
      desc = 'Next Reference',
    },
    {
      '[r',
      function()
        Snacks.words.jump(-vim.v.count1, true)
      end,
      desc = 'Prev Reference',
    },
  },
}

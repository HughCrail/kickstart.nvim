return {
  'ahmedkhalf/project.nvim',
  lazy = false,
  config = function()
    require('project_nvim').setup {
      exclude_dirs = { '~/.local/*' },
    }
  end,
  dependencies = {
    'folke/snacks.nvim',
  },
  keys = {
    {
      '<leader>pp',
      function()
        local project_nvim = require 'project_nvim'
        local results = project_nvim.get_recent_projects()

        -- Reverse results
        for i = 1, math.floor(#results / 2) do
          results[i], results[#results - i + 1] = results[#results - i + 1], results[i]
        end

        local longest_name = 0
        local items = {}
        for i, result in ipairs(results) do
          local name = vim.fs.basename(result)
          table.insert(items, {
            idx = i,
            score = i,
            text = result,
            dir = vim.fs.dirname(result) .. '/',
            file = result,
            name = name,
          })
          longest_name = math.max(longest_name, #name)
        end

        local picker = require 'snacks.picker'
        picker.pick {
          items = items,
          title = 'Recent Projects',
          format = function(item)
            local ret = {}
            ret[#ret + 1] = { item.dir, 'SnacksPickerComment' }
            ret[#ret + 1] = { ('%-' .. longest_name .. 's'):format(item.name), 'SnacksPickerLabel' }
            return ret
          end,
          confirm = function(p, item)
            p:close()
            vim.api.nvim_set_current_dir(item.file)
            picker.git_files {
              cwd = item.text,
              untracked = true,
              submodules = true,
            }
          end,
          win = {
            input = {
              keys = {
                ['<c-g>'] = { 'open_neogit', mode = { 'n', 'i' } },
                ['<c-f>'] = { { 'tcd', 'picker_files' }, mode = { 'n', 'i' } },
                ['<c-s>'] = { { 'tcd', 'picker_grep' }, mode = { 'n', 'i' } },
              },
            },
          },
          actions = {
            open_neogit = function(_, item)
              if item then
                local dir = Snacks.picker.util.dir(item.file)
                vim.api.nvim_set_current_dir(dir)
                require('neogit').open { cwd = dir, kind = 'replace' }
              end
            end,
          },
        }
      end,
      desc = 'Search Projects',
    },
  },
}

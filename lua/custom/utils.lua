local M = {}

local cache = {}
function M.memoize(fn)
  return function(...)
    local key = vim.inspect { ... }
    cache[fn] = cache[fn] or {}
    if cache[fn][key] == nil then
      cache[fn][key] = fn(...)
    end
    return cache[fn][key]
  end
end

local function basename(filename)
  local fname = vim.fn.fnamemodify(filename, ':t:r')
  local dot_index = string.find(fname, '%.')
  if dot_index then
    return string.sub(fname, 1, dot_index - 1)
  else
    return fname
  end
end

function M.gotoNextOtherFile()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    print 'No other files'
    return
  end
  local file_dir = vim.fn.expand '%:p:h'
  local base_name = basename(current_file)

  local all_files_in_dir = vim.fn.readdir(file_dir)
  local matching_files = {}

  for _, filename in ipairs(all_files_in_dir) do
    local fbasename = basename(filename)
    if base_name == fbasename then
      table.insert(matching_files, filename)
    end
  end

  if #matching_files <= 1 then
    print 'No other files'
    return -- Only one or no matching files found
  end

  table.sort(matching_files)

  -- 5. Find the current file in the sorted list
  local current_index = -1
  for i, file in ipairs(matching_files) do
    if file == vim.fn.fnamemodify(current_file, ':t') then
      current_index = i
      break
    end
  end

  if current_index == -1 then
    print 'UH OH!'
    return -- Should not happen if the logic is correct
  end

  -- 6. Navigate to the one with the alphabetically next extension (with wrap-around)
  local next_index = (current_index % #matching_files) + 1
  local next_file = matching_files[next_index]

  -- 7. Open the next file
  vim.cmd('edit ' .. vim.fn.escape(file_dir .. '/' .. next_file, '%#'))
end

function M.openJJUI()
  vim.defer_fn(function()
    vim.cmd 'startinsert!'
  end, 100)
  return Snacks.terminal('jjui', {
    cwd = vim.fn.getcwd(),
    win = {
      style = 'lazygit',
    },
    env = {
      JJ_EDITOR = 'nvr --remote-tab-wait',
    },
    auto_close = true,
  })
end

function M.openJJFromPicker(picker, item)
  if item then
    picker:close()
    local dir = Snacks.picker.util.dir(item)
    vim.api.nvim_set_current_dir(dir)
    M.openJJUI()
  end
end

return M

local M = {}
local uv = vim.uv or vim.loop
M.get_rplus_dirs = function(cb)
  local stdout = uv.new_pipe()
  local dirs = {}
  local out_str = ''
  uv.spawn('fd', {
    args = { 'bundle.json$', '--max-depth', '5', '--absolute-path' },
    stdio = { nil, stdout, nil },
    cwd = 'C:/dev/repos',
  }, function(_, _)
    -- split out_str by lines and add to dirs
    for file in out_str:gmatch '[^\r\n]+' do
      -- get dirname
      local dirname = vim.fs.dirname(file)
      table.insert(dirs, dirname)
    end
    vim.schedule(function()
      cb(dirs)
    end)
  end)

  uv.read_start(stdout, function(err, data)
    if data then
      out_str = out_str .. data
    end
  end)
end

return M

-- TODO: Add key to transform bullet into a task ( - [ ] ) and back again
-- TODO: Add key to put an x in a check mark or remove it
-- TODO: Add tags? e.g. :wait:
local function insert_siblling()
  local bufnr = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  vim.treesitter.get_parser(bufnr):parse()
  local node = vim.treesitter.get_node()
  while node do
    print(node:type())

    if node:type() == 'section' then
      local heading = node:child(0):child(0):type()
      local depth = string.match(heading, '^atx_h([0-9])_marker$')
      print('Heading d: ' .. depth)
      local row = node:end_()
      if row then
        print('Inserting h ' .. depth .. ' at row: ' .. row)
        local new_heading_text = string.rep('#', depth) .. ' '
        vim.fn.append(row, new_heading_text)
        vim.api.nvim_win_set_cursor(win, { row + 1, #new_heading_text })
        vim.cmd 'startinsert!'
      end
      return
    elseif node:type() == 'list_item' then
      local row = node:end_()
      local list_item_format = node:child(0)
      if not list_item_format then
        return
      end
      local is_task_list = node:child_count() >= 2 and node:child(1):type():find 'task_list_marker_' == 1
      local new_item = ''
      if list_item_format:type() == 'list_marker_dot' then
        local _, col = list_item_format:end_()
        new_item = string.rep(' ', col - 3) .. '1. '
      else
        local _, col = list_item_format:end_()
        new_item = string.rep(' ', col - 2) .. '- '
      end
      if is_task_list then
        new_item = new_item .. '[ ] '
      end
      vim.fn.append(row, new_item)
      vim.api.nvim_win_set_cursor(win, { row + 1, #new_item })
      vim.cmd 'startinsert!'
      return
    else
      node = node:parent()
    end
  end
end

local function smart_indent(cb, fb)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.treesitter.get_parser(bufnr):parse()
  local node = vim.treesitter.get_node()

  while node do
    if node:type() == 'atx_heading' then
      local row = node:start()
      local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1]
      vim.api.nvim_buf_set_lines(bufnr, row, row + 1, true, { cb(line) })
      return
    else
      node = node:parent()
    end
  end
  fb()
end
vim.keymap.set({ 'n' }, '<tab>', 'za', { desc = 'Toggle fold', silent = true, buffer = true })
vim.keymap.set({ 'n' }, '>>', function()
  smart_indent(function(ln)
    return '#' .. ln
  end, function()
    vim.cmd '>l'
  end)
end, { desc = 'Smart indent', silent = true, buffer = true })
vim.keymap.set({ 'n' }, '<<', function()
  smart_indent(function(ln)
    local s = string.gsub(ln, '#', '', 1)
    return s
  end, function()
    vim.cmd '<l'
  end)
end, { desc = 'Smart dedent', silent = true, buffer = true })
vim.keymap.set({ 'n', 'i' }, '<c-cr>', insert_siblling, { desc = 'insert deeper heading', silent = true, buffer = true })

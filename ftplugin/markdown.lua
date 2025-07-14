-- TODO: Add key to put an x in a check mark or remove it
-- TODO: Add tags? e.g. :wait:
-- TODO: fix cursor when indenting a task

local function is_task_list(listNode)
  if not listNode then
    return false
  end
  return listNode:child_count() >= 2 and listNode:child(1):type():find 'task_list_marker_' == 1
end

local function search_up(cb, fallback)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.treesitter.get_parser(bufnr):parse()
  local node = vim.treesitter.get_node()

  while node do
    if cb(node) then
      return
    else
      node = node:parent()
    end
  end
  fallback()
end

local function insert_siblling()
  search_up(function(node)
    if node:type() == 'section' then
      local heading = node:child(0):child(0):type()
      local depth = string.match(heading, '^atx_h([0-9])_marker$')
      local row = node:end_()
      if row then
        local new_heading_text = string.rep('#', depth) .. ' '
        vim.fn.append(row, new_heading_text)
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row + 1, #new_heading_text })
        vim.cmd 'startinsert!'
      end
      return true
    elseif node:type() == 'list_item' then
      local row = node:end_()
      local list_item_format = node:child(0)
      if not list_item_format then
        return true
      end
      local new_item = ''
      if list_item_format:type() == 'list_marker_dot' then
        local _, col = list_item_format:end_()
        new_item = string.rep(' ', col - 3) .. '1. '
      else
        local _, col = list_item_format:end_()
        new_item = string.rep(' ', col - 2) .. '- '
      end
      if is_task_list(node) then
        new_item = new_item .. '[ ] '
      end
      vim.fn.append(row, new_item)
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row + 1, #new_item })
      vim.cmd 'startinsert!'
      return true
    end
  end, function() end)
end

local function smart_indent(cb, fallback)
  local bufnr = vim.api.nvim_get_current_buf()
  search_up(function(node)
    if node:type() == 'atx_heading' then
      local row = node:start()
      local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1]
      local new_line = cb(line)
      vim.api.nvim_buf_set_lines(bufnr, row, row + 1, true, { new_line })
      -- local cursor = vim.api.nvim_win_get_cursor(window)
      -- vim.api.nvim_win_set_cursor(window, { cursor[1], cursor[2] + #new_line - #line })
      return true
    end
  end, fallback)
end

local function indent()
  smart_indent(function(ln)
    return '#' .. ln
  end, function()
    vim.cmd '>l'
  end)
end
local function dedent()
  smart_indent(function(ln)
    local s, _ = string.gsub(ln, '#', '', 1)
    return s
  end, function()
    vim.cmd '<l'
  end)
end

local function mark_impl(cb)
  local bufnr = vim.api.nvim_get_current_buf()
  search_up(function(node)
    if node:type() == 'list_item' and is_task_list(node) then
      local row = node:start()
      local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1]
      vim.api.nvim_buf_set_lines(bufnr, row, row + 1, true, { cb(line) })
      return true
    end
  end, function() end)
end

local function mark_todo()
  mark_impl(function(ln)
    local s, _ = string.gsub(ln, '%[x%]', '[ ]', 1)
    return s
  end)
end

local function mark_done()
  mark_impl(function(ln)
    local s, _ = string.gsub(ln, '%[ %]', '[x]', 1)
    return s
  end)
end

vim.keymap.set({ 'n' }, '<tab>', 'za', { desc = 'Toggle fold', silent = true, buffer = true })
vim.keymap.set({ 'n' }, '>>', indent, { desc = 'Smart indent', silent = true, buffer = true })
vim.keymap.set({ 'n' }, '<<', dedent, { desc = 'Smart dedent', silent = true, buffer = true })
-- vim.keymap.set({ 'i' }, '<tab>', indent, { desc = 'Smart indent', silent = true, buffer = true })
-- vim.keymap.set({ 'i' }, '<s-tab>', dedent, { desc = 'Smart dedent', silent = true, buffer = true })
vim.keymap.set({ 'n', 'i' }, '<c-cr>', insert_siblling, { desc = 'insert deeper heading', silent = true, buffer = true })
vim.keymap.set({ 'n' }, '<leader>mtd', mark_done, { desc = 'Mark done', silent = true, buffer = true })
vim.keymap.set({ 'n' }, '<leader>mtt', mark_todo, { desc = 'Mark done', silent = true, buffer = true })

-- vim.keymap.set("n", "<leader><leader>r", function() RELOAD("testrunner") end, { noremap = true })

local test_fns = vim.treesitter.query.parse_query("go", [[ 
[
 (function_declaration
   name: (identifier) @testname) @testfn (#match? @testname "^Test+")
 (call_expression
   function: (selector_expression) @subtestmethod (#eq? @subtestmethod "t.Run")
   arguments: (argument_list (interpreted_string_literal) @subtestname) ) @subtestfn
]
]])

local function get_root(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "go", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local function is_inside(lnnr, span)
  return lnnr >= span.top and lnnr <= span.bottom
end

local function get_distance(lnnr, span)
  if lnnr > span.bottom then
    return lnnr - span.bottom
  end
  return span.top - lnnr
end

local function get_span(node)
  local top, _, bottom, _ = node:range()
  return { top = top + 1, bottom = bottom + 1 }
end

local function get_test_name(bufnr, node)
  local r1, r2, r3, r4 = node:range()
  return vim.api.nvim_buf_get_text(bufnr, r1, r2, r3, r4, {})
end

local function get_subtest_name(bufnr, node)
  local r1, r2, r3, r4 = node:range()
  return vim.api.nvim_buf_get_text(bufnr, r1, r2 + 1, r3, r4 - 1, {})
end

local function process_max(lnnr, name, span, max)
  if is_inside(lnnr, span) then
    local size = span.bottom - span.top
    if max == nil or max.distance ~= nil or max.size >= size then
      max = { name = name, size = size }
    end
  else
    local distance = get_distance(lnnr, span)
    if max == nil or (max.distance ~= nil and max.distance > distance) then
      max = { name = name, distance = distance }
    end
  end
  return max
end

local function process_test_node(bufnr, lnnr, node, max)
  local name = get_test_name(bufnr, node)
  local span = get_span(node:parent())
  return process_max(lnnr, name, span, max)
end

local function process_subtest_node(bufnr, lnnr, node, max)
  local name = get_subtest_name(bufnr, node)
  local span = get_span(node:parent())
  return process_max(lnnr, name, span, max)
end

local function run()
  local bufnr = vim.api.nvim_get_current_buf()
  local lnnr = vim.api.nvim_win_get_cursor(0)[1]
  vim.pretty_print(lnnr)
  if vim.bo[bufnr].filetype ~= "go" then
    vim.notify("can only be used in go")
    return
  end
  local root = get_root(bufnr)
  vim.pretty_print(root)
  local max = nil
  for id, node in test_fns:iter_captures(root, bufnr, 0, -1) do
    local name = test_fns.captures[id]
    if name == "testname" then
      max = process_test_node(bufnr, lnnr, node, max)
    end
    if name == "subtestname" then
      max = process_subtest_node(bufnr, lnnr, node, max)
    end
  end
  vim.pretty_print(max.name)
end

-- vim.keymap.set("n", "<leader><leader>q", run, { noremap = true })

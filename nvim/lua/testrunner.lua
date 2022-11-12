vim.keymap.set("n", "<leader><leader>r", function() RELOAD("testrunner") end, { noremap = true })

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

local function run()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "go" then
    vim.notify("can only be used in go")
    return
  end
  local root = get_root(bufnr)
  vim.pretty_print(root)
  local positions = {}
  for id, node in test_fns:iter_captures(root, bufnr, 0, -1) do
    local name = test_fns.captures[id]
    if name == "testname" then
      local test_fn_range = { node:parent():range() }
      vim.pretty_print(test_fn_range)
      local r1, r2, r3, r4 = node:range()
      local fn_name = vim.api.nvim_buf_get_text(bufnr, r1, r2, r3, r4, {})
      -- local range = { node:range() }
      vim.pretty_print(fn_name)
    end
  end
end

vim.keymap.set("n", "<leader><leader>q", run, { noremap = true })

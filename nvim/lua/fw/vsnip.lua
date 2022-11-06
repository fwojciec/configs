local utils = require("fw.utils")
local opts = { noremap = true, silent = true }

local M = {}

M.config = function()
  vim.keymap.set({ "n", "s" }, "<C-k>",
    function()
      if vim.fn["vsnip#jumpable"](1) == 1 then
        utils.feedkey("<Plug>(vsnip-jump-next)")
      end
    end, opts)
  vim.keymap.set({ "n", "s" }, "<C-j>",
    function()
      if vim.fn["vsnip#jumpable"](-1) == 1 then
        utils.feedkey("<Plug>(vsnip-jump-prev)")
      end
    end, opts)
end

return M

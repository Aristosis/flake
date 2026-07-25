vim.keymap.set("t", "<Esc>", function ()
   vim.cmd("stopinsert")
end)

vim.keymap.set({"n","t"}, "<C-x>", function ()
   vim.cmd("bdelete")
end)

-- Terminal!!!
_G.bottom_term_buf = nil
vim.keymap.set("n", "<leader>t", function ()
   if not _G.bottom_term_buf or not vim.api.nvim_buf_is_valid(_G.bottom_term_buf) then
      _G.bottom_term_buf = vim.api.nvim_create_buf(false, true)

      vim.api.nvim_buf_call(_G.bottom_term_buf, function ()
         vim.cmd("term")
      end)

   end

   local win = vim.api.nvim_open_win(_G.bottom_term_buf, true, {
      split = "below",
      height = math.ceil(vim.o.lines / 5),
   })
   vim.wo[win].number = true
   vim.wo[win].relativenumber = true
   vim.cmd("startinsert")

   vim.api.nvim_buf_set_keymap(_G.bottom_term_buf, "n", "<Esc>", "", {callback = function ()
      vim.api.nvim_win_close(win, true)
   end})
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Toggle diagnostics display
vim.keymap.set("n", "<leader>d", function()
   vim.g.virtual_lines = not vim.g.virtual_lines
   vim.g.virtual_text = not vim.g.virtual_text
   vim.diagnostic.config {
      virtual_text = vim.g.virtual_text,
      virtual_lines = vim.g.virtual_lines,
   }
end, { desc = "Toggle virtual text/lines" })

vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() ~= 0 then return '<C-e><CR>'
  else return '<CR>'
  end
end, { expr = true, silent = true })

-- Rename within same line
vim.keymap.set("n", "<leader>r", function()
   vim.ui.input({ prompt = "Replace <x> with <y>: " }, function(test)
      if not test then
         return
      end
      local next_arg = string.gmatch(test, "(%w+)")
      local e = next_arg()
      local d = next_arg()

      if e and d then
         vim.cmd("s/" .. e .. "/" .. d .. "/g")
      end
   end)
end)

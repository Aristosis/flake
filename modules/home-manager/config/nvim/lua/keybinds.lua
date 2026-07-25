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

